import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formmetodebayar_controller.dart';  
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/payment_method_model.dart'; 
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/outlet/formoutlet_view.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class FormMetodeBayarView extends StatelessWidget {
  final PaymentMethodModel? model;
  final LaundryOutletModel? lo;
  const FormMetodeBayarView({super.key, this.model, this.lo});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormMetodeBayarController());
    controller.initModel(model, lo);
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form Metode Bayar'),
          actions: [
            Obx(()=>controller.loading.value ? const CupertinoActivityIndicator() : 
              IconButton(onPressed: (){
                  controller.submit();
              }, icon: const Icon(Icons.save))
            )
          ],
        ),
        body: SingleChildScrollView(child: Form(
          key: controller.form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx( () {
                return controller.loading.value ? 
                  const Center(child: CupertinoActivityIndicator()) : 
                Column(
                  children: [
                     _selectOutletLaundry(controller),
                
                    Row(
                      children: [
                      
                        const Expanded(flex: 2,child: Text('Metode Aktif'),),
                        Expanded(
                          child: Obx( ( ) {
                              return controller.loading.value ? const CupertinoActivityIndicator() : 
                              Transform.scale(
                                scale: .6,
                                child: LiteRollingSwitch(onTap: (){}, onDoubleTap: (){}, onSwipe: (){},
                                  value: controller.model.isActive ?? false, 
                                  width: 80,
                                  onChanged: (p0) {
                                      controller.setActive(p0);
                                }),
                              );
                            }
                          ),
                        )
                    ],
                  ),

                    _inputText(value: controller.modelObs.value.name, 
                      teksIfEmpty: 'Nama Pembayaran harus diisikan',
                      label: 'Nama Metode bayar',
                      onChanged: (value) {
                          controller.modelObs.value.name = value;
                      },
                    ),
                          
                    _inputText(value: controller.modelObs.value.bank, 
                      label: 'Bank',
                      onChanged: (value) {
                          controller.modelObs.value.bank = value;
                      },
                    ),

                    _inputText(value: controller.modelObs.value.accountNo, 
                      label: 'Nomor Rekening',
                      onChanged: (value) {
                          controller.modelObs.value.accountNo = value;
                      },
                    ),
                 
                
                     _inputText(value: controller.modelObs.value.description, 
                      label: 'Keterangan Atas Nama Rekening',
                      minLines: 2,
                      maxLines: 5,
                      onChanged: (value) {
                          controller.modelObs.value.description = value;
                      },
                    ),
                
                      
                
                
                  ],
                );
              }
            ),
          ),
        ),),
    );
  }

  SelectField _selectOutletLaundry(FormMetodeBayarController controller) {
    return SelectField(
                    title: 'Pilih Outlet',
                    label: const Text('Outlet'),
                    url: URLAddress.laundryOutlets,
                    validator: (value) {
                        return (controller.model.laundryOutletId ?? 0) <= 0 ? 'Outlet harus diisikan' : null;
                    },
                    controller: controller.OutletController,
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