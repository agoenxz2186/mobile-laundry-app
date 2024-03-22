import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:crypto/crypto.dart';

class FormLoginProviders with ChangeNotifier {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  bool loading = false;

  Future<Map> submitLogin() async {
    loading = true;
    notifyListeners();

    String token = '${txtEmail.text}:${txtPass.text}';
    token = base64Encode(utf8.encode(token));
    final r = await HTTP
        .get(URLAddress.auth, header: {'Authorization': 'basic $token'});
    // logD(r['body']);
    loading = false;
    notifyListeners();

    if (r['code'] == 200) {
      Global.pref?.setString('user', jsonEncode(r['json']['data']));
    }
    return r;
  }
}
