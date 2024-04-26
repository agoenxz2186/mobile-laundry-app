 
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart'; 
import 'package:laundry_owner/models/product_category_model.dart';
import 'package:laundry_owner/models/product_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class FormProductController extends GetxController{
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController KategoriController = TextEditingController();
    TextEditingController OutletController = TextEditingController();
    late ProductModel model;
    late LaundryOutletModel lo;
    RxBool isLoading = false.obs;


    void initModel(ProductModel? m, LaundryOutletModel lo){
        model = m ?? ProductModel();
        this.lo = lo;
        KategoriController = TextEditingController(text: m?.category ?? '');

        model.laundryOutletId = lo.id;
        model.outletLaundry = lo.name;
        OutletController.text = model.outletLaundry ?? '';
        
        isLoading.value = true;
         HTTP.get('${URLAddress.products}/${m?.idx}').then((value) {
        
            if(value['code'] == 200){
              final p = ProductModel.fromMap(value['json']['data']);
              model = p; 
              model.idx = m?.idx;
              model.laundryOutletId = p.laundryOutletId;
              OutletController.text = p.outletLaundry ?? '';
            } 
            
              isLoading.value = false;
         }).onError((error, stackTrace) {
          
              isLoading.value = false;
         });
    }

    void setActive(bool v){
        isLoading.value = true;
        model.isAvailable = v;
        isLoading.value = false;
    }
    Future submit()async{
      if(formKey.currentState?.validate() ?? false){
        isLoading.value = true;
        final r = await HTTP.post(URLAddress.products, data: model.toMap());
        logD(r);
        isLoading.value = false;
        
        if(r['code'] == 200){
            Get.back(result: true);
        }else{
            CherryToast.warning(
              title: const Text('Simpan Produk'),
              description: Text('${r['json']['message'] ?? 'Gagal menyimpan produk'}'),
            ).show(Get.context!);
        }
      } 
      return null;
    }

   void setCategory(ProductCategoryModel pm){
      isLoading.value = true;
      model.productCategoryId = pm.id;
      model.category = pm.name;
      KategoriController.text = pm.name ?? '';
      isLoading.value = false;
   }

   void setOutletLaundry(LaundryOutletModel lo){
    isLoading.value = true;
    model.laundryOutletId = lo.id;
    OutletController.text = lo.name ?? '';
    isLoading.value = false;
   }

}