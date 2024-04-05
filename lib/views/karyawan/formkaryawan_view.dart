import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_owner/controllers/formkaryawan_controller.dart';
import 'package:laundry_owner/models/user_model.dart'; 
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:string_validator/string_validator.dart';

class FormKaryawanView extends StatelessWidget {
  final UserModel? userModel;

  const FormKaryawanView({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormKaryawanController());
    controller.initModel(userModel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karyawan'),
        actions: [

            Obx(() => controller.loading.value == true ? 
              const CupertinoActivityIndicator() : 
              IconButton(onPressed: ()=>controller.submit(), icon: const Icon(MdiIcons.contentSave)) 
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.form,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Obx(  () {
                return controller.loading.value ?
                 const CupertinoActivityIndicator() : 
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      _inputNamaLengkap(controller),
                
                      _inputEmail(controller),
                
                      _inputNoHP(controller),
                
                      const Text('Tanggal Lahir'),
                      _inputTanggalLahir(controller, context),

                      const SizedBox(height: 10,),
                      const Text('Jenis Kelamin'),
                      _inputJenisKelamin(controller),

                      const SizedBox(height: 10,),
                      const Text('Peran'),
                      Global.auth?.role == 'SU' ?
                      _inputRoleSU(controller) :
                      Global.auth?.role == 'OLN' ?
                      _inputRoleOLN(controller) : const SizedBox.shrink()

                
                      
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _inputRoleOLN(FormKaryawanController controller) {
    return DropdownButtonFormField(
                      value: controller.model.role,  
                      items: const [
                        DropdownMenuItem(value: 'OLN',child: Text('Owner Laundry'),),
                        DropdownMenuItem(value: 'KLN',child: Text('Karyawan'),),
                      ], 
                      onChanged: (value) {
                        controller.model.role = value;
                      },
                    );
  }

  DropdownButtonFormField<String> _inputRoleSU(FormKaryawanController controller) {
    return DropdownButtonFormField(
                      value: controller.model.role,  
                      items: const [
                        DropdownMenuItem(value: 'SU',child: Text('Super Administrator'),),
                        DropdownMenuItem(value: 'ADM',child: Text('Administrator'),),
                        DropdownMenuItem(value: 'OLN',child: Text('Owner Laundry'),),
                        DropdownMenuItem(value: 'KLN',child: Text('Karyawan'),),
                      ], 
                      onChanged: (value) {
                        controller.model.role = value;
                      },
                    );
  }

  DropdownButtonFormField<String> _inputJenisKelamin(FormKaryawanController controller) {
    return DropdownButtonFormField(
              validator: (value) {
                return (controller.model.gender ?? '').isEmpty ? 'Jenis kelamin harus diisi' : null;
              },
                      value: controller.model.gender,  
                      items: const [
                        DropdownMenuItem(value: 'M',child: Text('Laki-Laki'),),
                        DropdownMenuItem(value: 'F',child: Text('Perempuan'),),
                      ], 
                      onChanged: (value) {
                        controller.model.gender = value;
                      },
                    );
  }

  Widget inputField(String label, Widget wInput)=>Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      wInput,
      const SizedBox(height: 10,)
    ],
  );

  TextFormField _inputTanggalLahir(FormKaryawanController controller, BuildContext context) {
    return TextFormField(
                      controller: TextEditingController(text: controller.model.formatDateBirth()),
                      readOnly: true,
                      onTap: () {
                        showDatePicker(context: context,  
                          initialDate: controller.model.tgllahir(),
                          firstDate: DateTime(1940), 
                          lastDate: DateTime.now()).then((value) {
                              if(value != null){
                                  controller.setTglLahir(value);
                              }
                          });
                         
                      },
                    );
  }

  Widget _inputNoHP(FormKaryawanController controller) {
    return inputField('No HP', TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: TextEditingController(text: controller.model.phone ?? ''),
                      onChanged: (value) {
                        controller.model.phone = value;
                      },
                    ));
  }

  Widget _inputEmail(FormKaryawanController controller) {
    return inputField('Email', TextFormField(
                      validator: (value) {
                        return (controller.model.email ?? '').isEmpty ? 'Email boleh kosong' : (
                            isEmail(controller.model.email ?? '') ? null : 'Format email salah'
                        );
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: TextEditingController(text: controller.model.email ?? ''),
                      onChanged: (value) {
                        controller.model.email = value;
                      },
                    ));
  }

  Widget _inputNamaLengkap(FormKaryawanController controller) {
    return inputField('Nama Lengkap', TextFormField(
                      validator: (value) {
                        return (controller.model.fullName ?? '').isEmpty ? 'Nama tidak boleh kosong' : null;
                      },
                      controller: TextEditingController(text: controller.model.fullName ?? ''),
                      onChanged: (value) {
                        controller.model.fullName = value;
                      },
                    ));
  }
}