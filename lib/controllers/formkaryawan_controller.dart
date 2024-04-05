
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            final r = await HTTP.get( '${URLAddress.users}/${model.idx}' );
            logD(r);
            if(r['code'] == 200){
              final u = UserModel.fromMap(r['json']['data']);
              model = u;
              model.idx = userModel.idx;
            }
        }

    }
}