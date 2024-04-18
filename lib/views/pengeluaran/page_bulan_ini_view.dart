import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageBulanIniView extends StatelessWidget {
  const PageBulanIniView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_PageBulanIniController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

      }, child: const Icon(MdiIcons.plus),),
      body: SmartRefresher(controller: controller.refreshController,
        onRefresh: () => controller.onRefresh(),
        onLoading: () => controller.onLoadMore(),
        child: ListView(
          children: [
            if(controller.data.isEmpty)
              const EmptyData(pesan: 'Belum ada pengeluaran bulan ini terbukukan.',)
          ],
        ),
      ),
    );
  }
}

class _PageBulanIniController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: true);
  List data  = [];
  RxBool isLoading = false.obs;
  int _page = 1;
  String keyword = '';

  Future onRefresh([int page = 1])async{
      _page = page;
      refreshController.refreshCompleted();
  }

  Future onLoadMore()async{
      onRefresh(_page + 1);
      refreshController.loadComplete();
  }
}