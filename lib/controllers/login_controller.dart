
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/models/auth_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class LoginController extends GetxController{
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  var loading = false.obs;

  Future<Map> submitLogin() async {
    loading.value = true;

    String token = '${txtEmail.text}:${txtPass.text}';
    token = base64Encode(utf8.encode(token));
    final r = await HTTP
        .get(URLAddress.auth, header: {'Authorization': 'basic $token'});
     logD(r['body']);
    loading.value = false;
    

    if (r['code'] == 200) {
      Global.pref?.setString('user', jsonEncode(r['json']['data']));
      
      final user = Global.pref?.getString('user') ?? '';
    // logD("isi user $user");
      Global.auth = AuthModel.fromJson(user);
    }
    return r;
  }
  
}