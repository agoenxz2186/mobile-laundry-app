import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier{
    int _activeIndex = 0;

    void setActiveIndex(int idx){
        _activeIndex = idx;
        notifyListeners();
    }

    int getActiveIndex(){
      return _activeIndex;
    }
}