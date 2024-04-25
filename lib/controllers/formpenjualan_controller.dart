
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_owner/models/customer_model.dart';
import 'package:laundry_owner/models/detail_order_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/order_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class FormPenjualanController extends GetxController{
   OrderModel model = OrderModel();
   RxList<DetailOrderModel> detailData = <DetailOrderModel>[].obs;
   
   RxBool loading = false.obs;
   GlobalKey<FormState> formKey = GlobalKey();
   TextEditingController outletController = TextEditingController(); 
   TextEditingController pelangganController = TextEditingController(); 

   void initModel(OrderModel? m)async{
     model = m ?? OrderModel(
      orderAt: DateFormat('y-MM-dd').format(DateTime.now())
     );

     if(m != null){
        loading.value = true;
        final r = await HTTP.get('${URLAddress.orders}/show/${m.idx}');
        if(r['code'] == 200){
            final mm = OrderModel.fromMap(r['json']['data']);
            model = mm;
            outletController.text = mm.laundryOutlet ?? '';
        } 
        loading.value = false;
     }
   }

   void setOutletLaundry(LaundryOutletModel m){ 
      model.laundryOutlet = m.name;
      model.laundryOutletId = m.id;
      outletController.text = m.name ?? '';
      loading.value = false;
   }

   void pilihOrderAt(){
      showDatePicker(context: Get.context!, 
        firstDate: DateTime(DateTime.now().year - 2), 
        lastDate: DateTime.now(),
        initialDate: model.orderAtDateTime() ?? DateTime.now()
      ).then((value){
          if(value != null){
              loading.value = true;
              model.orderAt = DateFormat('y-MM-dd').format(value);
              loading.value = false;
              logD(model.orderAt);
          }
      });
   }

   void setCustomer(dynamic n){
      loading.value = true;
      final c = CustomerModel.fromMap(n);
      model.customer = '${c.name} - ${c.phone}';
      model.customerId = c.id;
      model.customerPhone = c.phone;
      pelangganController.text = model.customer ?? '';
      loading.value = false;
   }

   void submit()async{
      final valid = formKey.currentState?.validate() ?? false;
      
      if(valid){
          loading.value = true;
          final r = await HTTP.post(URLAddress.orders, data:model.toMap());
          loading.value = false;

          logD("simpan order : $r");

          final error = r['json']['error'];
          if(error != null){
              var desc = '';
              for(var n in error.keys){
                desc += (desc.isEmpty ? '' : '\n') + error[n][0];   
              }
              CherryToast.error(
                title: const Text('Gagal simpan'),
                description: Text(desc),
              ).show(Get.context!);
          }
      }

   }
}