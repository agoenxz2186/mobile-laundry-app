
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/outlet/formoutlet_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';

class ListOutletController extends GetxController{
  
  RxList<LaundryOutletModel> data = <LaundryOutletModel>[].obs;
  
  var isLoading = false.obs;
  var modeSelected = false.obs;

  String keyword = '';
  RxMap itemSelected = {}.obs;
  int _page = 1;
  RefreshController refreshController = RefreshController(initialRefresh: true);

  Future _load([page = 1]) async {
    _page = page;
    final l = await HTTP.get('${URLAddress.laundryOutlets}?page=$_page');
    logD(l);

    if (l['code'] == 200) {
      final dt = l['json']['data'];
      if(page == 1)data.clear();

      List<LaundryOutletModel> t = [];
      for(final d in dt){
         t.add( LaundryOutletModel.fromMap(d) );
      }
      logD(t);
      data.addAll(t);
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

  void onItemTap(LaundryOutletModel v){
    if( modeSelected.value == true){
        addItemSelected(v.idx);
    }else{
        Get.to(()=>FormOutletView(model: v),
          transition: Transition.zoom
        )?.then((value) {
            if(value == true){
                refresh();
            }
        });
    }
  }

  void addItemSelected(String? id){
      final r = itemSelected[id];
      if(r == null){
          itemSelected[id] = 1;
      }else{
          itemSelected.remove(id);  
      }
  }

  bool isItemSelected(LaundryOutletModel v){
     final r = itemSelected[v.id];
     logD("isitem selected = $r");
     return r != null;
  }
  void clearItemSelected(){
      modeSelected.value =false;
      itemSelected.clear();
  }

  Future hapusData()async{
      Get.close(0);
      final r = await HTTP.delete(URLAddress.laundryOutlets, data:{
        'id': itemSelected.keys.toList()
      });
      if(r['code'] == 200){
          clearItemSelected();
          refresh();
      }
  }
}