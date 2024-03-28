 
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/map_choice_view.dart';
import 'package:laundry_owner/controllers/formoutlet_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/global_variable.dart'; 
import 'package:string_validator/string_validator.dart' as validator;
import 'package:latlong2/latlong.dart';

class FormOutletView extends StatelessWidget {
  final LaundryOutletModel? model;

  const FormOutletView({super.key, this.model});

  Widget inputField(String label, Widget wInput)=>Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      wInput,
      const SizedBox(height: 10,)
    ],
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormOutletController());
    controller.init(model); 

    return Obx( () {
        return Scaffold(
              appBar: AppBar(
                title: const Text('Outlet'),
                actions: [
                  controller.isLoading.value ? const CupertinoActivityIndicator() : IconButton(onPressed: (){
                      controller.submit().then((value) {
                          if(value['code'] == 200){
                              Navigator.pop(context, true);
                          }else{
                              CherryToast.warning(
                                title: const Text('Outlet Laundry'),
                                description: const Text('Gagal menyimpan data'),
                              ).show(context);
                          }
                      });
                  }, icon: const Icon(MdiIcons.contentSave,))
                ],
              ),
              body: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25,20,25,10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputField('Nama Outlet',  TextFormField(
                               validator: (value) {
                                 return (value?.isEmpty ?? true) ? 'Nama outlet laundry harus diisikan' : null;
                               },
                               onChanged: (value) {
                                controller.model.name = value;
                              },
                              controller:
                                  TextEditingController(text: controller.model.name ?? ''),
                            )),
                  
                            TextButton.icon(onPressed: (){
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (c)=>  
                                    MapChoiceView( latLng:  controller.model.getPosition() ))).then((value){
                                      if(value is LatLng){
                                        controller.setPointLocation(value);
                                      }
                                });
                            }, icon: const Icon(MdiIcons.mapMarker), label: const Text('Pilih Alamat Lokasi di Peta')),
                            Text('${controller.model.pointLocation ?? ''}'),
                            const SizedBox(height: 10,),
                            
                             inputField('Alamat',  TextFormField(
                              validator: (value) {
                                 return (value?.isEmpty ?? true) ? 'Alamat outlet laundry harus diisikan' : null;
                               },
                              minLines: 2,
                              maxLines: 3,
                               onChanged: (value) {
                                controller.model.address = value;
                              },
                              controller:
                                  TextEditingController(text: controller.model.address ?? ''),
                            )),
                   
                            Row(children: [
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                     const Text('Kota'),
                                      TextField( 
                                        onChanged: (value) {
                                          controller.model.city = value;
                                        },
                                        controller:
                                            TextEditingController(text: controller.model.city ?? ''),
                                      ), 
                                ],
                              )),
                              const SizedBox(width: 10,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [ 
                                      const Text('Kecamatan'),
                                      TextField( 
                                        onChanged: (value) {
                                          controller.model.district = value;
                                        },
                                        controller:
                                            TextEditingController(text: controller.model.district ?? ''),
                                      ),
                                ],
                              ))
                  
                            ],),
                           
                            const SizedBox(
                              height: 10,
                            ),
                          
                            Row(
                              children: [
                                Expanded(
                                  child: inputField( 'Kelurahan',
                                        TextField( 
                                          onChanged: (value) {
                                            controller.model.subdistrict = value;
                                          },
                                          controller:
                                              TextEditingController(text: controller.model.subdistrict ?? ''),
                                        )),
                                ),
                  
                                const SizedBox(width: 10,), 
                                
                              ],
                            ),
                          
                             
                            const SizedBox(
                              height: 10,
                            ),
                        
                            Row(
                              children: [
                                 Expanded(
                                    child: inputField('Nomor Telepon',  TextField( 
                                      onChanged: (value) {
                                        controller.model.phone = value;
                                      },
                                      controller:
                                          TextEditingController(text: controller.model.phone ?? ''),
                                    )),
                                  ), 
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: inputField('Email',  TextFormField( 
                                      onChanged: (value) {
                                        controller.model.email = value;
                                      },
                                      validator: (value) => (value??'').isNotEmpty ? (
                                          validator.isEmail(value??'') ? null : 'Isikan alamat email') : null,
                                      controller:
                                          TextEditingController(text: controller.model.email ?? ''),
                                    )),
                                  ), 
                              
                              ],
                            ),
                  
                            inputField('web',  TextField( 
                              onChanged: (value) {
                                controller.model.web = value;
                              },
                              controller:
                                  TextEditingController(text:controller.model.web ?? ''),
                            )), 
                        
                        
                      
                          ],
                        ),
                      ),
                    ),
                  )
            );
      }
    ); 

  }
}
