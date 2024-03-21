import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:laundry_owner/utils/global_variable.dart';

class HTTP {
  static Map<String, String> headers() {
    return {
      'Content-Type': 'application/json',
      'Api-Token': '110b71af6c5c6c4982f716301dcaec29',
      'Session-ID': Global.sessionID
    };
  }

  static Map response(http.Response r) {
    try {
      return {'code': r.statusCode, 'json': jsonDecode(r.body), 'body': r.body};
    } catch (e) {}
    return {'code': 408, 'body': 'Waktu koneksi berakhir', 'json': {}};
  }

  static Future<Map> get(String url,
      {Map<String, String> header = const {}}) async {
    final h = headers()..addAll(header);
    logD(h);

    final r = await http
        .get(Uri.parse(url), headers: headers()..addAll(header))
        .timeout(const Duration(seconds: 5))
        .onError((error, stackTrace) {
      return http.Response('', 408);
    });
    return response(r);
  }

  static Future<Map> post(String url,
      {Map? data, Map<String, String> header = const {}}) async {
    final r = await http
        .post(Uri.parse(url),
            body: jsonEncode(data), headers: headers()..addAll(header))
        .timeout(const Duration(seconds: 5))
        .onError((error, stackTrace) {
      return http.Response('', 408);
    });
    return response(r);
  }

  static Future<Map> delete(String url,
      {Map? data, Map<String, String> header = const {}}) async {
    final r = await http
        .delete(Uri.parse(url),
            body: jsonEncode(data), headers: headers()..addAll(header))
        .timeout(const Duration(seconds: 5))
        .onError((error, stackTrace) {
      return http.Response('', 408);
    });
    return response(r);
  }
}
