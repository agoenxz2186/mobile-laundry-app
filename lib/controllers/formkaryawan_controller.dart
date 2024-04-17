
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_owner/models/user_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class FormKaryawanController extends GetxController{
    RxBool loading = false.obs;
    UserModel model = UserModel();

    GlobalKey<FormState> form = GlobalKey();


    void initModel(UserModel? userModel)async{
        model = userModel ?? UserModel();

        if( userModel != null ){
            loading.value = true;
            final r = await HTTP.get( '${URLAddress.users}/${model.idx}' );
            logD(r);
            if(r['code'] == 200){
              final u = UserModel.fromMap(r['json']['data']);
              model = u;
              model.idx = userModel.idx;
            }
            loading.value = false;
        }

    }

    void setTglLahir(DateTime tgl){
       
        loading.value = true;
        model.dateBirth = DateFormat('yyyy-MM-dd').format(tgl);
        loading.value = false;
    
    }

    void submit()async{
        if( (form.currentState?.validate() ?? false) == false )
          return;

        loading.value = true;
        final r = await HTTP.post(URLAddress.users, data: model.toMap());
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
              title: const Text('Simpan Karyawan'),
              description: Text('${r['message'] ??  "Data gagal disimpan"}'),
           ).show(Get.context!);
        }
    }
}