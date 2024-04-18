import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/metodebayar/listmetodebayar_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectOutletView extends StatelessWidget {
  const SelectOutletView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_SelectOutletController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Outlet'),
      ),
      body: Obx( ( ) {
          return SmartRefresher(
              controller: controller.refreshController,
              onRefresh: ()=> controller.loadRefresh(),
              onLoading: () => controller.loadMore(),
              child: ListView(
                children: [
                  controller.isLoading.value ? const CupertinoActivityIndicator() : SizedBox(),

                  if(controller.data.isEmpty)
                    const EmptyData(pesan: 'Outlet belum ada',),

                  for(var n in controller.data)
                    ListTile(
                      onTap: () {
                          Get.to(()=>ListMetodeBayarView(lo: n,));
                      },
                      title: Text('${n.name}'),
                      subtitle: Text('${n.address}'),
                    )
                ],
              ),
          );
        }
      ),
    );
  }
}

class _SelectOutletController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String keyword = '';
  int _page = 1;
  RxBool isLoading = false.obs;
  List<LaundryOutletModel> data = [];

  Future loadRefresh([int page = 1])async{
      _page = page;
      isLoading.value = true;

      if(page == 1)data.clear();

      final r = await HTTP.get('${URLAddress.laundryOutlets}/?keyword=${Uri.encodeFull(keyword)}&page=$page');
      if(r['code'] == 200){
          final dt = r['json']['data'] ?? [];
          for(var dd in dt ){
              data.add( LaundryOutletModel.fromMap(dd) );
          } 
      }   

      refreshController.refreshCompleted();
      isLoading.value = false;
  }

  Future loadMore()async{
      loadRefresh(_page+1);
      refreshController.loadComplete();
  }
}