
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/product_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/produk/formproduct_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListProdukController extends GetxController{
  
  RxList<ProductModel> data = <ProductModel>[].obs;
  late LaundryOutletModel lo;
  
  var isLoading = false.obs;
  var modeSelected = false.obs;

  String keyword = '';
  RxMap itemSelected = {}.obs;
  int _page = 1;
  RefreshController refreshController = RefreshController(initialRefresh: true);

  init(LaundryOutletModel? lo){
      this.lo = lo ?? LaundryOutletModel();
  }

  Future _load([page = 1]) async {
    _page = page;
    final l = await HTTP.get('${URLAddress.products}/${lo.id}/?page=$_page');
    logD(l);

    if (l['code'] == 200) {
      final dt = l['json']['data'];
      if(page == 1)data.clear();

      List<ProductModel> t = [];
      for(final d in dt){
         t.add( ProductModel.fromMap(d) );
      }
      logD(t);
      data.addAll(t);
    }
     
  }

  void addItemSelected(String? id){
    isLoading.value = true;
      final r = itemSelected[id];
      if(r == null){
          itemSelected[id] = 1;
      }else{
          itemSelected.remove(id);  
      }
    isLoading.value = false;  
  }

  bool isItemSelected(ProductModel v){
     final r = itemSelected[v.id];
     logD("isitem selected = $r");
     return r != null;
  }

  Future newForm()async{
      Get.to(()=> FormProductView(lo: lo,))?.then((value) {
        if(value == true){
          loadrefresh();
        }
      });
  }

  Future loadrefresh() async {
    _load(1);
    refreshController.refreshCompleted();
  }

  Future loadmore() async {
    _load(_page + 1);
    refreshController.loadComplete();
  }

  void onItemTap(ProductModel v){
    if( modeSelected.value == true){
        addItemSelected(v.idx);
    }else{
        Get.to(()=>FormProductView(model: v, lo: lo,),
          transition: Transition.zoom
        )?.then((value) {
          logD('hasil simpan $value');
            if(value == true){
                loadrefresh();
            }
        });
    }
  }

  void clearItemSelected(){
      modeSelected.value =false;
      itemSelected.clear();
  }

  Future hapusData()async{
      Get.close(0);
      final r = await HTTP.delete(URLAddress.products, data:{
        'id': itemSelected.keys.toList()
      });
      logD(r);

      if(r['code'] == 200){
          clearItemSelected();
          loadrefresh();
      }else{
         CherryToast.error(
          title: const Text('Hapus'),
          description: const Text('Gagal hapus data produk'),
         ).show(Get.context!);
      }
  }
}