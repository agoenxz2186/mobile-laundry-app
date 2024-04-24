import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/models/order_model.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/penjualan/formpenjualan_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageOrderBaruView extends StatefulWidget {
  const PageOrderBaruView({super.key});

  @override
  State<PageOrderBaruView> createState() => _PageOrderBaruViewState();
}

class _PageOrderBaruViewState extends State<PageOrderBaruView> with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  int _page = 1;
  String keyword = '';
  List<OrderModel> data = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(onPressed: (){
            Get.to(()=>const FormPenjualanView())?.then((value) {
                _refreshController.requestRefresh();
            });
        }, child: const Icon(MdiIcons.plus),),
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: () => onLoading(),
          onRefresh: () => onRefresh(),
          enablePullUp: true,
          child: ListView(
            children: [
               if(data.isEmpty)
                const EmptyData(pesan: 'Belum ada transaksi tercatat',),

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

    final r = await HTTP.get('${URLAddress.orders}/baru/&page=$page&keyword=${Uri.encodeFull(keyword)}');
    if(r['code'] == 200){
        if(page == 1) data.clear();

        for(var n in r['json']['data'] ?? []){
            data.add( OrderModel.fromMap(n) );
        }
    } 
     _refreshController.refreshCompleted();
     setState(() { });
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}