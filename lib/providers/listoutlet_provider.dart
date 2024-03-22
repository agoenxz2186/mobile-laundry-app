import 'package:flutter/material.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListOutletProvider with ChangeNotifier {
  List data = [];
  bool isLoading = false;
  String keyword = '';
  int _page = 1;
  RefreshController refreshController = RefreshController(initialRefresh: true);

  Future refresh() async {
    _page = 1;
    final l = await HTTP.get(URLAddress.laundryOutlets);

    logD(l);
    if (l['code'] == 200) {
      final data = l['json']['data'];
    }
    refreshController.refreshCompleted();
  }

  Future loadmore() async {
    refreshController.loadComplete();
  }
}
