
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 
import 'package:get/get.dart';  
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/payment_method_model.dart'; 
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart'; 

class FormMetodeBayarController extends GetxController{
    RxBool loading = false.obs; 
    PaymentMethodModel model = PaymentMethodModel();
    Rx<PaymentMethodModel> modelObs = PaymentMethodModel().obs;
    TextEditingController OutletController = TextEditingController();

    GlobalKey<FormState> form = GlobalKey();


    void initModel(PaymentMethodModel? pm, LaundryOutletModel? lo)async{
        model = pm ?? PaymentMethodModel();
        model.laundryOutletId ??= lo?.id;
        model.laundryOutlet ??= lo?.name;
        OutletController.text = model.laundryOutlet ?? '';
        logD('laundry : ${model.laundryOutlet}');

        if( pm != null ){
            loading.value = true;
            final r = await HTTP.get( '${URLAddress.paymentMethods}/show/${model.idx}' );
            logD(r);
            if(r['code'] == 200){
              final u = PaymentMethodModel.fromMap(r['json']['data']);
              model = u;
              model.idx = pm.idx;
            }
            loading.value = false;
        }
        modelObs.value = model;

    }
 
    void submit()async{
      logD('submit click ${form.currentState?.validate()}');
        if( (form.currentState?.validate() ?? false) == false )
          return;

        loading.value = true;
        final r = await HTTP.post(URLAddress.paymentMethods, data: model.toMap());
        logD(r);
        loading.value = false;

        if(r['code'] == 200){
          final error = r['json']['error'];
          if(error == null){
            Get.back(result: true);
          }else{
              CherryToast.error(
                title: const Text('Kesalahan Simpan'),
                description: Text('${error}'),
              ).show(Get.context!);
          }
        }else{
           CherryToast.error(
              title: const Text('Simpan Pelanggan'),
              description: Text('${r['message'] ??  "Data gagal disimpan"}'),
           ).show(Get.context!);
        }
    }

    void setOutletLaundry(LaundryOutletModel lo){
      loading.value = true;
      model.laundryOutletId = lo.id;
      OutletController.text = lo.name ?? '';
      loading.value = false;
   }

    void setActive(bool v){
        loading.value = true;
        model.isActive = v;
        loading.value = false;
    }
}