import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';

class FormOutletProvider with ChangeNotifier {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  LaundryOutletModel? model;

  void init(LaundryOutletModel? model) {
    this.model = model ?? LaundryOutletModel();
  }
}
