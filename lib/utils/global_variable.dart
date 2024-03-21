import 'package:flutter/foundation.dart';
import 'package:laundry_owner/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? pref;
  static String sessionID = '';
  static AuthModel? auth;
}

void logD(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
