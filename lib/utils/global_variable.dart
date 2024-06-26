import 'package:flutter/foundation.dart';
import 'package:laundry_owner/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

class Global {
  static SharedPreferences? pref;
  static String sessionID = '';
  static UserModel? auth;
  static LatLng? currentLocation;
}

void logD(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
