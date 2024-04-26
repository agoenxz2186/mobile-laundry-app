
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/models/detail_order_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/product_model.dart';

class FormDetailOrderController extends GetxController{
   GlobalKey<FormState> formKey = GlobalKey();
   TextEditingController productText = TextEditingController();
   DetailOrderModel model = DetailOrderModel();
   ProductModel productModel = ProductModel();
   late LaundryOutletModel lo; 
   RxBool loading = false.obs;

   void init(LaundryOutletModel lo){
     this.lo = lo;
   }

   void setProduct(Map<String, dynamic> m){
      loading.value = true;
      productModel = ProductModel.fromMap(m);
      model.product = productModel.name;
      model.productId = productModel.id;
      productText.text = model.product!;
      loading.value = false;
   }
}