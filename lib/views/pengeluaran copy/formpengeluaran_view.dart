import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formpengeluaran_controller.dart';
import 'package:laundry_owner/models/accounting_number.dart';
import 'package:laundry_owner/models/cash_journal_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/text_formatter.dart';
import 'package:laundry_owner/utils/url_address.dart'; 

class FormPengeluaranView extends StatelessWidget {
  final LaundryOutletModel lo;
  final CashJournalModel? model;
  const FormPengeluaranView(this.lo, {this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormPengeluaranController());
    controller.initModel(model, lo);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pengeluaran'),
            Text('${lo.name}', style: const TextStyle(fontSize: 13),)
          ],
        ),
        actions: [
           Obx(() => controller.loading.value ? 
            const CupertinoActivityIndicator() :
            IconButton(
              onPressed: ()=>controller.submit(), 
              icon: const Icon(MdiIcons.contentSave)
            )),

           PopupMenuButton(
              child: const Icon(Icons.more_vert),
              onSelected: (value) {
                 controller.hapusData();
              }, 
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    height: 2,
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    value: 'H',child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.grey,),
                        SizedBox(width: 5,),
                        Text('Hapus'),
                      ],
                    ),)
                ];
            },
          )
        ],
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx( () {
              return Form(
                key: controller.form,
                child: Column(
                  children: [
                      if(controller.loading.value)const Center(child: CupertinoActivityIndicator(),),
                      
                      _inputText(value: controller.model.transactionAt(),
                        label: 'Tanggal Transaksi',
                        teksIfEmpty: 'Tanggal harus diisikan',
                        readOnly: true,
                        onTap: () => controller.pilihTanggal()
                      ),

                      SelectField(
                        label: const Text('Jenis Transaksi'),
                        controller: controller.accountNumberTextController,
                        url: URLAddress.accountingNumberPengeluaran,
                        validator: (value) {
                          return (controller.model.accountNo ?? '' ).isEmpty ? 'Jenis transaksi harus dipilih' : null;
                        },
                        title: 'Pilih Jenis Transaksi',
                        onItemRender: (n) {
                            final aa = AccountingNumber.fromMap(n);
                            return ListTile(
                              title: Text('${aa.code} - ${aa.name}'),
                            );
                        },
                        onChanged: (value) {
                          controller.setAccountNumber( AccountingNumber.fromMap(value) );
                        },
                      ),

                      const SizedBox(height: 15,),
                
                      _inputText(
                        value: controller.model.name,
                        label: 'Nama Transaksi',
                        teksIfEmpty: 'Nama transaksi harus diisikan',
                        onChanged: (value) {
                          controller.model.name = value;
                        },
                      ),
                
                      _inputText(
                        value: '${controller.model.nominal ?? 0}',
                        label: 'Nominal',
                        formatter: [
                          FilteringTextInputFormatter.digitsOnly, CurrencyInputFormatter()
                        ],
                        textAlign: TextAlign.right,
                        teksIfEmpty: 'Nominal harus diisikan',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          var n = value.toString().replaceAll('Rp ', '');
                          n = n.toString().replaceAll('.', '');
                          controller.model.nominal = double.tryParse(n) ?? 0;
                          
                          logD("nilai ${controller.model.nominal}");
                        },
                      ),

                       _inputText(
                        value: controller.model.description,
                        label: 'Deskripsi',  
                        minLines: 2,
                        maxLines: 5,
                        onChanged: (value) {
                          controller.model.description = value ?? 0;
                        },
                      )
                  ],
                ),
              );
            }
          ),
        ),
      ) );
           
  }
 

  Widget _inputText({
    String? value,
    String? label,
    String? teksIfEmpty,
    ValueChanged? onChanged,
    TextInputType? keyboardType,
    int? minLines, int? maxLines,
    bool readOnly = false,
    VoidCallback? onTap,
    TextAlign textAlign = TextAlign.start,
    List<TextInputFormatter>? formatter
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
                  inputFormatters: formatter,
                  onTap: onTap,
                  readOnly: readOnly,
                  keyboardType: keyboardType,
                  minLines: minLines,
                  maxLines: maxLines,
                  textAlign: textAlign,
                  controller: TextEditingController(text: value),
                  validator: (value) {
                    return (value ?? '').isEmpty ? teksIfEmpty : null;
                  },
                  decoration: InputDecoration(
                    label: Text('$label'), 
                  ),
                  onChanged: onChanged,
                ),
    );
  }


}