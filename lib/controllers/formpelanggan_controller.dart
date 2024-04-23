
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/models/customer_model.dart'; 
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';
import 'package:latlong2/latlong.dart';
import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

class FormPelangganController extends GetxController{
    RxBool loading = false.obs; 
    CustomerModel model = CustomerModel();
    Rx<CustomerModel> modelObs = CustomerModel().obs;

    GlobalKey<FormState> form = GlobalKey();


    void initModel(CustomerModel? userModel)async{
        model = userModel ?? CustomerModel();

        if( userModel != null ){
            loading.value = true;
            final r = await HTTP.get( '${URLAddress.customers}/${model.idx}' );
            logD(r);
            if(r['code'] == 200){
              final u = CustomerModel.fromMap(r['json']['data']);
              model = u;
              model.idx = userModel.idx;
            }
            loading.value = false;
        }
        modelObs.value = model;

    }
 
    void submit()async{
      logD('submit click ${form.currentState?.validate()}');
        if( (form.currentState?.validate() ?? false) == false )
          return;

        loading.value = true;
        final r = await HTTP.post(URLAddress.customers, data: model.toMap());
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

    void setPointLocation(LatLng v){
      loading.value = true;
      model.pointLocation = '${v.latitude}, ${v.longitude}';
      logD('posisis : ${model.pointLocation}');

      NominatimFlutter.instance.reverse(
        reverseRequest: ReverseRequest(lat: v.latitude, lon: v.longitude)
      ).then((value){
            loading.value = true;
            model.city = value.address?['city'];
            model.district =  value.address?['city_district'];
            model.subdistrict = value.address?['village'];
            model.address = value.address?['road'];
            loading.value = false;
            modelObs.value = model;
            logD("$value");
            logD(modelObs.value.pointLocation);
      }).onError((error, stackTrace) {
          loading.value = false;
      });


      // GeocodingPlatform.instance?.placemarkFromCoordinates(v.latitude, v.longitude)
      // .then((value) {
      //   logD(value);
      //   if(value.isNotEmpty){
      //       loading.value = true;
      //       model.city = value.first.subAdministrativeArea;
      //       model.district = value.first.locality;
      //       model.subdistrict = value.first.subLocality;
      //       model.address = value.first.street;
      //       loading.value = false;
      //       modelObs.value = model;
      //       logD("tes");
      //       logD(modelObs.value.pointLocation);
      //   }
      // }); 
      // modelObs.value = model;
      // loading.value = false;
  }
}