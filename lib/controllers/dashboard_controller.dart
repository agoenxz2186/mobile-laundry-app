
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:latlong2/latlong.dart';

class DashboardController extends GetxController{
   var _activeIndex = 0.obs;

  void setActiveIndex(int idx) {
    _activeIndex.value = idx;
  }

  int getActiveIndex() {
    return _activeIndex.value;
  }

  void initRefreshLocation()async{
    var locperm = await Geolocator.checkPermission();

    if(locperm == LocationPermission.denied || locperm == LocationPermission.deniedForever || 
      locperm == LocationPermission.unableToDetermine
    ){
        locperm = await Geolocator.requestPermission();
    }

    if(locperm == LocationPermission.denied || locperm == LocationPermission.deniedForever || 
      locperm == LocationPermission.unableToDetermine
    ){
        return;
    }


    Geolocator.getPositionStream(locationSettings: const LocationSettings()).listen((event) {
        Global.currentLocation = LatLng(event.latitude, event.longitude);
    });
  }
}