import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formpenjualan_controller.dart';
import 'package:laundry_owner/models/customer_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/order_model.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/outlet/formoutlet_view.dart';
import 'package:laundry_owner/views/penjualan/detailorder_view.dart';

class FormPenjualanView extends StatelessWidget {
  final OrderModel? model;
  const FormPenjualanView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormPenjualanController());
    controller.initModel(model);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Jasa / Barang'),
        actions: [
          Obx(() => controller.loading.value ? const CupertinoActivityIndicator() :
            IconButton(
              onPressed: ()=>controller.submit(), 
              icon: const Icon(MdiIcons.contentSave))
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx( ( ) {
              return Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     if(controller.loading.value)
                      const CupertinoActivityIndicator(),

                      _selectOutletLaundry(controller),
                      const SizedBox(height: 15,),

                      _inputText(
                        label: 'Tanggal Order',
                        teksIfEmpty: 'Tanggal order harus diisikan',
                        value: controller.model.fmtOrderAt(),
                        readOnly: true,
                        onTap: ()=>controller.pilihOrderAt()
                      ),

                      _pilihPelanggan(controller),

                      const SizedBox(height: 10,),
                      const Text('Status'),
                      DropdownButtonFormField(
                        validator: (value) => (value ?? '').isEmpty ? 'Status Harus ditentukan' : null,
                        items: const [
                          DropdownMenuItem(value: 'baru',child: Text('Baru'),),
                          DropdownMenuItem(value: 'proses',child: Text('Proses'),),
                          DropdownMenuItem(value: 'batal',child: Text('Batal'),),
                          DropdownMenuItem(value: 'selesai',child: Text('Selesai'),),
                        ], onChanged: (value) {
                          controller.model.status = value;
                      },),

                      const SizedBox(height: 15,),

                      _detailOrder(controller)


                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _detailOrder(FormPenjualanController controller)=>Column(
    children: [
        for(var m in controller.detailData)
          ListTile(
            title: Text('${m.product}'),
            subtitle: Column(
              children: [
                Text('${m.qty} ${m.qtyUnit} x @ ${m.priceSale}'),
                Text('${m.estimateFinish}')
              ],
            ),
          ),

        ElevatedButton.icon(onPressed: (){
            showDialog(context: Get.context!, builder: (context) {
              return const Dialog(
                insetPadding: EdgeInsets.all(10),
                child: DetailOrderView() 
              );
            });
        }, icon: const Icon(MdiIcons.cart), label: const Text('Tambah Item Jasa'))
    ],
  );

  SelectField _pilihPelanggan(FormPenjualanController controller) {
    return SelectField(
            label: const Text('Pelanggan'),
            validator: (value) => (value ?? '') == '' ? 'Pelanggan harus dipilih' : null,
            controller: controller.pelangganController,
            title: 'Pilih Pelangan',
            url: URLAddress.customers ,
            onChanged: (value) => controller.setCustomer(value),
            onItemRender: (n) {
                final c = CustomerModel.fromMap(n);
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('${c.name}',
                    style: const TextStyle(fontSize: 19),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${c.phone}'),
                      Text('${c.address}')
                    ],
                  ),
                );
            },
          );
  }

  
  SelectField _selectOutletLaundry(FormPenjualanController controller) {
    return SelectField(
                    title: 'Pilih Outlet',
                    label: const Text('Outlet'),
                    url: URLAddress.laundryOutlets,
                    validator: (value) {
                        return (controller.model.laundryOutletId ?? 0) <= 0 ? 'Outlet harus diisikan' : null;
                    },
                    controller: controller.outletController,
                    onAddNewTap: (controller){
                        Get.to(()=>const FormOutletView())?.then((value) {
                            controller.loadRefresh();
                        });
                    },
                    onChanged: (value) { 
                        controller.setOutletLaundry( LaundryOutletModel.fromMap(value) );
                    },
                    onItemRender: (n) {       
                        final r = LaundryOutletModel.fromMap(n);
                        return ListTile(title: Text('${r.name}'));
                    },
                  );
  }

  Widget _inputText({
    String? value,
    String? label,
    String? teksIfEmpty,
    ValueChanged? onChanged,
    TextInputType? keyboardType,
    int? minLines, int? maxLines,
    bool readOnly = false,
    VoidCallback? onTap
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
                  onTap: onTap,
                  readOnly: readOnly,
                  keyboardType: keyboardType,
                  minLines: minLines,
                  maxLines: maxLines,
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