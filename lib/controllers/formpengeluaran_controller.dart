
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:laundry_owner/models/cash_journal_model.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class FormPengeluaranController extends GetxController{
  GlobalKey<FormState> form = GlobalKey();
  CashJournalModel model = CashJournalModel();
  RxBool loading = false.obs;
  TextEditingController OutletController = TextEditingController();
  

  void initModel(CashJournalModel? pm, LaundryOutletModel? lo)async{
      model = pm ?? CashJournalModel();
      model.laundryOutletId ??= lo?.id;
      model.laundryOutlet ??= lo?.name;
      OutletController.text = model.laundryOutlet ?? '';
      logD('laundry : ${model.laundryOutlet}');

      if( pm != null ){
          loading.value = true;
          final r = await HTTP.get( '${URLAddress.cashJournal}/show/${model.idx}' );
          logD(r);
          if(r['code'] == 200){
            final u = CashJournalModel.fromMap(r['json']['data']);
            model = u;
            model.idx = pm.idx;
          }
          loading.value = false;
      } 

  }

  void submit()async{
    logD('submit click ${form.currentState?.validate()}');
      if( (form.currentState?.validate() ?? false) == false )
        return;

      loading.value = true;
      final r = await HTTP.post(URLAddress.paymentMethods, data: model.toMap());
      logD(r);
      loading.value = false;

      if(r['code'] == 200){
        final error = r['json']['error'];
        if(error == null){
          Get.back(result: true);
        }else{
            CherryToast.error(
              title: const Text('Kesalahan Simpan'),
              description: Text('${error}'),
            ).show(Get.context!);
        }
      }else{
          CherryToast.error(
            title: const Text('Simpan Pelanggan'),
            description: Text('${r['message'] ??  "Data gagal disimpan"}'),
          ).show(Get.context!);
      }
  }

  void setOutletLaundry(LaundryOutletModel lo){
    loading.value = true;
    model.laundryOutletId = lo.id;
    OutletController.text = lo.name ?? '';
    loading.value = false;
  }

  void pilihTanggal(){
     showDatePicker(context: Get.context!, 
        initialDate: model.dtTransAt(),
        firstDate: DateTime(DateTime.now().year - 10), 
        lastDate: DateTime.now()
      ).then((value){
          if(value != null){
              loading.value = true;
              model.setTransAt(value);
              loading.value = false;
          }
      });
      
  }
 
  
}