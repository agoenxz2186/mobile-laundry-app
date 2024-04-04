import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formproduct_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/product_category_model.dart';
import 'package:laundry_owner/models/product_model.dart'; 
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/categoryproduct/formcategoryproduct_view.dart';
import 'package:laundry_owner/views/outlet/formoutlet_view.dart';

class FormProductView extends StatelessWidget {
  final ProductModel? model;
  const FormProductView({super.key, this.model});



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormProductController());
    controller.initModel(model);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk / Jasa'),
        actions: [
            Obx(()=>controller.isLoading.value == true ? const CupertinoActivityIndicator() : 
              IconButton(onPressed: ()=>controller.submit(),
                icon: const Icon(Icons.save))
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Obx( () {
                return controller.isLoading.value ? const CupertinoActivityIndicator() : Column(
                  children: [
                    SelectField(
                      title: 'Pilih Outlet',
                      label: const Text('Outlet'),
                      url: URLAddress.laundryOutlets,
                      controller: controller.OutletController,
                      onAddNewTap: (){
                          Get.to(()=>const FormOutletView());
                      },
                      onChanged: (value) { 
                          controller.setOutletLaundry( LaundryOutletModel.fromMap(value) );
                      },
                      onItemRender: (n) {       
                          final r = LaundryOutletModel.fromMap(n);
                          return ListTile(title: Text('${r.name}'));
                      },
                    ),
                
                    const SizedBox(height: 10,),
                
                    inputField('Nama Produk', TextFormField(
                      validator: (value) {
                        return (value ?? '').isEmpty ? 'Nama Produk harus diisikan' : null; 
                      },
                      controller: TextEditingController(text: controller.model.name),
                      onChanged: (value) {
                        controller.model.name = value;
                      },
                    )),
                    
                    inputField('Keterangan', TextFormField(
                      controller: TextEditingController(text: controller.model.description),
                      onChanged: (value) {
                        controller.model.description = value;
                      },
                      minLines: 2, maxLines: 4,
                    )),
                
                    SelectField(
                      title: 'Pilih Kategori Produk',
                      label: const Text('Kategori Produk'),
                      url: URLAddress.productCategories,
                      controller: controller.KategoriController,
                      onAddNewTap: (){
                          Get.to(()=>const FormCategoryProductView());
                      },
                      onChanged: (value) { 
                          controller.setCategory( ProductCategoryModel.fromMap(value) );
                      },
                      onItemRender: (n) {       
                          final r = ProductCategoryModel.fromMap(n);
                          return ListTile(title: Text('${r.name}'));
                      },
                    ),
                    
                    const SizedBox(height: 10,),
                
                    inputField('Harga Modal', TextFormField(
                      controller: TextEditingController(text: '${controller.model.dppPrice ?? 0}'),
                      onChanged: (value) {
                        controller.model.dppPrice = double.tryParse(value) ?? 0;
                      }, 
                    )),
                
                    inputField('Harga Jual', TextFormField(
                      controller: TextEditingController(text: '${controller.model.salePrice ?? 0}'),
                      onChanged: (value) {
                        controller.model.salePrice = double.tryParse(value) ?? 0;
                      }, 
                    )),
                
                    Row(
                      children: [
                          Expanded( 
                            child: inputField('Durasi Layanan', TextFormField(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: '${controller.model.duration ?? 0}'),
                              onChanged: (value) {
                                controller.model.duration = double.tryParse(value) ?? 0;
                              }, 
                            )),
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:8),
                              child: DropdownButtonFormField(
                                value: controller.model.durationUnit ?? 'jam',
                                items: const [
                                  DropdownMenuItem(value: 'jam',child: Text('Jam'),),
                                  DropdownMenuItem(value: 'hari',child: Text('Hari'),),
                                  DropdownMenuItem(value: 'pekan',child: Text('Pekan'),),
                                ], onChanged: (value) {
                                  controller.model.durationUnit = value;
                                },),
                            ),
                          )
                      ],
                    ),
                
                     Row(
                      children: [
                          Expanded( 
                            child: inputField('Jumlah Satuan', TextFormField(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: '${controller.model.qty ?? 0}'),
                              onChanged: (value) {
                                controller.model.qty = double.tryParse(value) ?? 0;
                              }, 
                            )),
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:8),
                              child: DropdownButtonFormField(items: const [
                                  DropdownMenuItem(value: 'kg',child: Text('Kg'),),
                                  DropdownMenuItem(value: 'pcs',child: Text('Pcs'),),
                                ], value: controller.model.qtyUnit ?? 'pcs', onChanged: (value) {
                                  controller.model.qtyUnit = value;
                                },),
                            ),
                          )
                      ],
                    ),
                
                   inputField('Minimum Jumlah diorder', TextFormField(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: '${controller.model.minimumQty ?? 0}'),
                              onChanged: (value) {
                                controller.model.minimumQty = double.tryParse(value) ?? 0;
                              }, 
                    )) 
                
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  
  Widget inputField(String label, Widget wInput)=>Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      wInput,
      const SizedBox(height: 10,)
    ],
  );

}