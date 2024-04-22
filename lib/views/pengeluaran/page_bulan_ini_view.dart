import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/models/cash_journal_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/pengeluaran/formpengeluaran_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageBulanIniView extends StatelessWidget {
  final LaundryOutletModel lo;
  const PageBulanIniView(this.lo, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_PageBulanIniController(lo));
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
          Get.to(()=> FormPengeluaranView(lo));
      }, child: const Icon(MdiIcons.plus),),
      body: Obx( () {
          return SmartRefresher(controller: controller.refreshController,
            onRefresh: () => controller.onRefresh(),
            onLoading: () => controller.onLoadMore(),
            enablePullDown: true, enablePullUp: true,
            child: ListView(
              children: [
            
                if(controller.data.isEmpty)
                  const EmptyData(pesan: 'Belum ada pengeluaran bulan ini terbukukan.',)
                
                else
                  for(var n in controller.data)
                    ListTile(
                      title: Text('${n.accountNo} - ${n.account}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${n.name}'),
                          Text(n.transactionAt(), style: const TextStyle(fontSize: 12),),
                        ],
                      ),
                      trailing: Text('${n.nominal}'),
                    )
              ],
            ),
          );
        }
      ),
    );
  }
}

class _PageBulanIniController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: true);
  RxList<CashJournalModel> data  = <CashJournalModel>[].obs;
  RxBool isLoading = false.obs;
  int _page = 1;
  String keyword = '';
  LaundryOutletModel lo;

  _PageBulanIniController(this.lo);

  Future onRefresh([int page = 1])async{
      _page = page;
      isLoading.value = true;
      final tahun = DateTime.now().year;
      final bulan = DateTime.now().month;
      final url = '${URLAddress.cashJournal}/${lo.idx}/$tahun/$bulan/?keyword=${Uri.encodeFull(keyword)}&page=$page';
      final r = await HTTP.get(url); 

      if(page == 1)data.clear();

      if(r['code'] == 200){
         for(var n in r['json']['data'] ?? []){
            data.add( CashJournalModel.fromMap(n) );
         }
      }
      isLoading.value = false;
      refreshController.refreshCompleted();
  }

  Future onLoadMore()async{
      onRefresh(_page + 1);
      refreshController.loadComplete();
  }
}