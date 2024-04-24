import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formpenjualan_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/outlet/formoutlet_view.dart';

class FormPenjualanView extends StatelessWidget {
  const FormPenjualanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormPenjualanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Jasa / Barang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx( ( ) {
              return Form(
                key: controller.formKey,
                child: Column(
                  children: [
                     if(controller.loading.value)
                      const CupertinoActivityIndicator(),

                      _inputText(
                        label: 'Tanggal Order',
                        value: controller.model.orderAt,
                        readOnly: true,
                        onTap: ()=>controller.pilihOrderAt()
                      ),

                      _inputText(
                        label: 'Pelanggan'
                      )
                  ],
                ),
              );
            }
          ),
        ),
      ),
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