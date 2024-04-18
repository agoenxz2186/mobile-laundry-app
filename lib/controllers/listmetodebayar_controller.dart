
import 'package:get/get.dart';
import 'package:laundry_owner/models/customer_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/payment_method_model.dart';
import 'package:laundry_owner/models/user_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:laundry_owner/views/metodebayar/formmetodebayar_view.dart';
import 'package:laundry_owner/views/pelanggan/formpelanggan_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListMetodeBayarController extends GetxController{
   RxBool isLoading = false.obs;
   RxList<PaymentMethodModel> data = <PaymentMethodModel>[].obs;
   String keyword = '';
   int _page = 1;
   RxMap itemSelected = RxMap();
   RxBool modeSelected = false.obs;
   RefreshController refreshController = RefreshController(initialRefresh: true);
   final LaundryOutletModel lo;

   ListMetodeBayarController(this.lo);

   Future loadRefresh([int page = 1])async{
     _page = page;
     isLoading.value = true; 
     final r = await HTTP.get( '${URLAddress.paymentMethods}/${lo.idx}/?keyword=${Uri.encodeFull(keyword)}&page=$_page' );
     logD(r);
     isLoading.value = false; 
     refreshController.refreshCompleted();

     if(r['code'] == 200){
        final d = r['json']['data'];
        
        if(page <=1) data.clear();

        for(var n in d){
            data.add(  PaymentMethodModel.fromMap(n) );
        }
     }

   }
   
   Future loadMore()async{
      loadRefresh(_page+1);
      refreshController.loadComplete();
   }

   
  void onItemTap(PaymentMethodModel v){
    if( modeSelected.value == true){
        addItemSelected(v.idx);
    }else{
        Get.to(()=>FormMetodeBayarView(model: v),
          transition: Transition.zoom
        )?.then((value) {
            if(value == true){
                loadRefresh();
            }
        });
    }
  }

  void addItemSelected(String? id){
      final r = itemSelected[id];
      if(r == null){
          itemSelected[id ?? ''] = 1;
      }else{
          itemSelected.remove(id);  
      }
  }

  bool isItemSelected(PaymentMethodModel v){
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
      final r = await HTTP.delete(URLAddress.paymentMethods, data:{
        'id': itemSelected.keys.toList()
      });
      logD(itemSelected.keys.toList());
      logD(r);
      if(r['code'] == 200){
          clearItemSelected();
          loadRefresh();
      }
  }

}