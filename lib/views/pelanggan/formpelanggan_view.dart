import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/map_choice_view.dart';
import 'package:laundry_owner/controllers/formpelanggan_controller.dart';
import 'package:laundry_owner/models/customer_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:laundry_owner/utils/global_variable.dart';

class FormPelangganView extends StatelessWidget {
  final CustomerModel? model;
  const FormPelangganView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormPelangganController());
    controller.initModel(model);
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form Pelanggan'),
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
                return controller.loading.value ? const CupertinoActivityIndicator() : 
                Column(
                  children: [
                    _inputText(value: controller.modelObs.value.name, 
                      teksIfEmpty: 'Nama Lengkap harus diisikan',
                      label: 'Nama Lengkap',
                      onChanged: (value) {
                          controller.modelObs.value.name = value;
                      },
                    ),
                          
                    _inputText(value: controller.modelObs.value.phone, 
                      label: 'Nomor HP',
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                          controller.modelObs.value.phone = value;
                      },
                    ),
                
                     _inputText(value: controller.modelObs.value.pointLocation, 
                      label: 'Koordinat Lokasi Rumah',
                      readOnly: true,
                      onTap: () {
                          Get.to(()=>MapChoiceView( 
                              latLng:  controller.modelObs.value.getPosition() ))
                              ?.then((value){
                                logD(value);
                                if(value is LatLng){
                                  controller.setPointLocation(value);
                                }
                              } );
                      },
                      
                    ),
                
                     _inputText(value: controller.modelObs.value.address, 
                      label: 'Alamat Lengkap',
                      keyboardType: TextInputType.streetAddress,
                      minLines: 2,
                      maxLines: 5,
                      onChanged: (value) {
                          controller.modelObs.value.address = value;
                      },
                    ),
                
                    
                     _inputText(value: controller.modelObs.value.city, 
                      label: 'Kab/Kota',  
                      onChanged: (value) {
                          controller.modelObs.value.city = value;
                      },
                    ),
                
                     _inputText(value: controller.modelObs.value.district, 
                      label: 'Kecamatan',  
                      onChanged: (value) {
                          controller.modelObs.value.district = value;
                      },
                    ),
                
                    _inputText(value: controller.modelObs.value.subdistrict, 
                      label: 'Kelurahan',  
                      onChanged: (value) {
                          controller.modelObs.value.subdistrict = value;
                      },
                    ),
                
                    _inputText(value: controller.modelObs.value.village, 
                      label: 'Desa',  
                      onChanged: (value) {
                          controller.modelObs.value.village = value;
                      },
                    ),
                
                
                     _inputText(value: controller.modelObs.value.notes, 
                      label: 'Catatan',  
                      onChanged: (value) {
                          controller.modelObs.value.notes = value;
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