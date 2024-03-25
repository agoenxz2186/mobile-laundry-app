import 'package:flutter/material.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListOutletProvider with ChangeNotifier {
  List<LaundryOutletModel> data = [];
  bool isLoading = false;
  String keyword = '';
  int _page = 1;
  RefreshController refreshController = RefreshController(initialRefresh: true);

  Future _load([page = 1]) async {
    _page = page;
    final l = await HTTP.get('${URLAddress.laundryOutlets}?page=$_page');
 logD(l);

    if (l['code'] == 200) {
      final dt = l['json']['data'];
      if(page == 1)data = [];

      for(final d in dt){
         data.add( LaundryOutletModel.fromMap(d) );
      }
      notifyListeners();
    }
     
  }


  Future refresh() async {
    _load(1);
    refreshController.refreshCompleted();
  }

  Future loadmore() async {
    _load(_page + 1);
    refreshController.loadComplete();
  }
}
