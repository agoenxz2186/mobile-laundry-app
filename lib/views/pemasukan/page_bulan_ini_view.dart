 
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart'; 
import 'package:intl/intl.dart';
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/models/cash_journal_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/pemasukan/formpemasukan_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageBulanIniView extends StatefulWidget {
  final LaundryOutletModel lo;
  const PageBulanIniView(this.lo, {super.key});

  @override
  State<PageBulanIniView> createState() => _PageBulanIniViewState();
}

class _PageBulanIniViewState extends State<PageBulanIniView> with AutomaticKeepAliveClientMixin {
  late _PageBulanIniController controller;

  @override
  void initState() { 
    super.initState();
    controller = Get.put(_PageBulanIniController(widget.lo));
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
   
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
          Get.to(()=> FormPemasukanView(widget.lo))?.then((value) {
              controller.onRefresh();
          });
      }, child: const Icon(MdiIcons.plus),),
      body: Obx( () {
          return SmartRefresher(controller: controller.refreshController,
            onRefresh: () => controller.onRefresh(),
            onLoading: () => controller.onLoadMore(),
            enablePullDown: true, enablePullUp: true,
            child: ListView(
              children: [
            
                if(controller.data.isEmpty)
                  const EmptyData(pesan: 'Belum ada Pemasukan bulan ini terbukukan.',)
                
                else
                  for(var n in controller.data)
                    ListTile(
                      onTap: () {
                         Get.to(()=>FormPemasukanView(widget.lo, model: n,))?.then((value) {
                            controller.onRefresh();
                         });
                      },
                      title: Text('${n.accountNo} - ${n.account}', style: const TextStyle(fontSize: 13),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.description,
                                size: 16, color: Colors.grey,
                              ),
                              const SizedBox(width: 5,),
                              Text('${n.name}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month,
                                size: 16, color: Colors.grey,
                              ),
                              const SizedBox(width: 5,),
                              Text(n.transactionAt(), style: const TextStyle(fontSize: 12),),
                            ],
                          ),
                        ],
                      ), 
                      trailing: Text(n.fmtNominal()   ),
                    ),
                const Divider(),
                ListTile(
                  title: const Text('Total'),
                  trailing: Text('${controller.calcTotal()} ',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )

              ],
            ),
          );
        }
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
      final url = '${URLAddress.cashJournal}/pemasukan/${lo.idx}/$tahun/$bulan/?keyword=${Uri.encodeFull(keyword)}&page=$page';
      final r = await HTTP.get(url); 
      // logD("pendapatan : $r");

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

  String calcTotal(){
     double total = 0;
     for(var n in data){
       total += n.nominal ?? 0;
     }
     return NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp ').format(total);
  }
}