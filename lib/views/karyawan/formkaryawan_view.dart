import 'package:flutter/material.dart';
import 'package:laundry_owner/models/user_model.dart';

class FormKaryawanView extends StatelessWidget {
  final UserModel? userModel;

  const FormKaryawanView({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karyawan'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}