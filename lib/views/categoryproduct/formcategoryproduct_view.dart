import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formcategoryproduct_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/product_category_model.dart'; 
import 'package:laundry_owner/utils/url_address.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart'; 

class FormCategoryProductView extends StatelessWidget {
  const FormCategoryProductView({super.key, this.model});

  final ProductCategoryModel? model;

  
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
    final controller = Get.put(FormCategoryProductController());
    controller.init(model);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Kategori Produk'),
        actions: [
          Obx(() => controller.isLoading.value == true ? 
                    const CupertinoActivityIndicator() : 
                      IconButton(onPressed: ()=> controller.submit(), 
                        icon: const Icon(MdiIcons.contentSave),))
          
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SelectField(
                    validator: (value) {
                      return controller.model.laundryOutletId == null ? 'Outlet harus dipilih' : null;
                    },
                    label: const Text('Pilih Outlet'),
                    url: URLAddress.laundryOutlets,
                    title: 'Laundry Outlet',
                    controller: controller.controllerSelectOutlet,
                    onChanged: (s){
                        final lo = LaundryOutletModel.fromMap(s); 
                        controller.setOutlet(lo);
                    },
                    onItemRender: (n) {
                     
                        final lo = LaundryOutletModel.fromMap(n);
                        return ListTile(
                            title: Text(lo.name ?? ''),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lo.address ?? ''),
                                Text(lo.district ?? ''),
                                Text(lo.city ?? '')
                              ],
                            ),
                        );
                    },
                  ),
            
                  const SizedBox(height: 10,),
              
                  inputField('Nama Kategori', TextFormField(
                      validator: (value) {
                          return (value ?? '').isEmpty ? 'Kategori harus diisikan' : null;
                      },
                      controller: TextEditingController(text: controller.model.name),
                      onChanged: (value) {
                          controller.model.name = value;
                      },
                  )),
            
                  inputField('Keterangan', TextFormField(
                      minLines: 2, maxLines: 3,
                      controller: TextEditingController(text: controller.model.description),
                      onChanged: (value) {
                          controller.model.description = value;
                      },
                  )),

                  Row(
                    children: [
                      
                      const Expanded(flex: 2,child: Text('Status Aktif'),),
                      Expanded(
                        child: Obx( ( ) {
                            return controller.isLoading.value ? const CupertinoActivityIndicator() : 
                            Transform.scale(
                              scale: .7,
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
                            
              ],
            ),
          ),
        ),
      ),
    );
  }
}