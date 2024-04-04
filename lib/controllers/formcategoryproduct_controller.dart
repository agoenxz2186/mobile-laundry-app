
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/product_category_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class FormCategoryProductController extends GetxController{
    GlobalKey<FormState> formKey  = GlobalKey();
    late ProductCategoryModel model;
    TextEditingController controllerSelectOutlet = TextEditingController();
    RxBool isLoading = false.obs;

    void init(ProductCategoryModel? model){
       this.model = model ?? ProductCategoryModel();
       controllerSelectOutlet.text = this.model.laundryOutlet ?? '';

    }

    void setActive(bool n){
        isLoading.value = true;
        model.isActive = n;
        isLoading.value = false;
    }

    Future submit()async{
      if(formKey.currentState?.validate() == true){
        isLoading.value = true;
        final r = await HTTP.post(URLAddress.productCategories, data: model.toMap());
        isLoading.value = false;
        logD(r);
        return r;
      }else{
        return null;
      }
    }

    void setOutlet(LaundryOutletModel lo){
       model.laundryOutlet = lo.name;
       model.laundryOutletId = lo.id;
       controllerSelectOutlet.text = lo.name ?? '';
    }

}