import 'package:flutter/material.dart';
import 'package:laundry_owner/models/order_model.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageOrderProsesView extends StatefulWidget {
  const PageOrderProsesView({super.key});

  @override
  State<PageOrderProsesView> createState() => _PageOrderBaruViewState();
}

class _PageOrderBaruViewState extends State<PageOrderProsesView> with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  int _page = 1;
  String keyword = '';
  List<OrderModel> data = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: () => onLoading(),
          onRefresh: () => onRefresh(),
          enablePullUp: true,
          child: ListView(
            children: [
               for(var n in data)
                ListTile(
                  title: Text('${n.orderAt}'),
                  subtitle: Text('${n.customer}'),
                )
            ],
          ),
        ),
    );
  }

  void onLoading()async{
     onRefresh(_page + 1);
     _refreshController.loadComplete();
  }

  void onRefresh([int page=1])async{
    _page = 1;

    final r = await HTTP.get('${URLAddress.orders}/?status=proses/&page=$page&keyword=${Uri.encodeFull(keyword)}');
    if(r['code'] == 200){
        if(page == 1) data.clear();

        for(var n in r['json']['data'] ?? []){
            data.add( OrderModel.fromMap(n) );
        }
    } 
     _refreshController.refreshCompleted();
  }
  
  @override 
  bool get wantKeepAlive => true;
}