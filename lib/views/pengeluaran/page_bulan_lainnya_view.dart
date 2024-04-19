 
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
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageBulanLainnyaView extends StatelessWidget {
  final LaundryOutletModel lo;
  const PageBulanLainnyaView(this.lo, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_PageBulanLainnyaController(lo));
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

      }, child: const Icon(MdiIcons.plus),),
      body: Obx( () {
          return SmartRefresher(controller: controller.refreshController,
            onRefresh: () => controller.onRefresh(),
            onLoading: () => controller.onLoadMore(),
            child: ListView(
              children: [
            
                if(controller.mapData.isEmpty)
                  const EmptyData(pesan: 'Belum ada pengeluaran bulan ini terbukukan.',)
                
                else
                  for(var n in controller.mapData.keys)
                    _itemData(n, controller.mapData[n])
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _itemData(String n, List<CashJournalModel>? data) {
    return ExpansionTile(title: Text(n),
      children: [
          for(CashJournalModel n in data ?? [])
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
    );
  }
}

class _PageBulanLainnyaController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: true);
 
  RxMap<String, List<CashJournalModel>> mapData = <String, List<CashJournalModel>>{}.obs;

  RxBool isLoading = false.obs;
  int _page = 1;
  String keyword = '';
  LaundryOutletModel lo;

  _PageBulanLainnyaController(this.lo);

  Future onRefresh([int page = 1])async{
      _page = page;
      isLoading.value = true; 
      final url = '${URLAddress.cashJournal}/${lo.idx}/?keyword=${Uri.encodeFull(keyword)}&page=$page';
      final r = await HTTP.get(url); 

      if(page == 1){ 
        mapData.clear();
      }

      if(r['code'] == 200){
         for(var n in r['json']['data'] ?? []){
            final c = CashJournalModel.fromMap(n);
            List<CashJournalModel>? nn = mapData[c.periode()];
            if(nn == null){
                nn = [];
            }
            nn.add(c);
            mapData[c.periode()] = nn;
         }
         logD("isi mapData : $mapData");
      }
      isLoading.value = false;
      refreshController.refreshCompleted();
  }

  Future onLoadMore()async{
      onRefresh(_page + 1);
      refreshController.loadComplete();
  }
}