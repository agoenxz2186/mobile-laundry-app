 
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:laundry_owner/utils/url_address.dart';

class FormOutletController extends GetxController{
  var isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();
  LaundryOutletModel model = LaundryOutletModel();

  Future init(LaundryOutletModel? model)async {
    if(model != null){
       isLoading.value = true;
       final r = await HTTP.get( '${URLAddress.laundryOutlets}/${model.idx}' );
       isLoading.value = false;
       logD(r);
       if(r['code'] == 200){
          this.model = LaundryOutletModel.fromMap( r['json']['data'] );
          this.model.idx = model.idx;
          return;
       }
    }
    this.model = model ?? LaundryOutletModel();
  }

  void setPointLocation(LatLng v){
      isLoading.value = true;
      model.pointLocation = '${v.latitude}, ${v.longitude}';
      GeocodingPlatform.instance?.placemarkFromCoordinates(v.latitude, v.longitude)
      .then((value) {
        if(value.isNotEmpty){
            isLoading.value = true;
            model.city = value.first.subAdministrativeArea;
            model.district = value.first.locality;
            model.subdistrict = value.first.subLocality;
            model.address = value.first.street;
            isLoading.value = false;
        }
      }); 
      isLoading.value = false;
  }

  Future submit()async{
    final v = formKey.currentState?.validate() ?? false;
    if(v){
        isLoading.value = true; 

        final r = await HTTP.post( URLAddress.laundryOutlets, data: model.toMap() );
        logD(r);
        isLoading.value = false; 
        return r;
    }
  }
  
  
}