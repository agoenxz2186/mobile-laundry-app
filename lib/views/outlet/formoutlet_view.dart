import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/providers/formoutlet_provider.dart';
import 'package:provider/provider.dart';

class FormOutletView extends StatelessWidget {
  final LaundryOutletModel? model;

  const FormOutletView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    context.read<FormOutletProvider>().init(model);

    return Consumer<FormOutletProvider>(
      builder: (context, prov, w) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Outlet'),
            actions: [
              prov.isLoading ? const CupertinoActivityIndicator() : IconButton(onPressed: (){
                  prov.submit();
              }, icon: const Icon(MdiIcons.contentSave,))
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: prov.formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25,20,25,10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama Outlet Laundry'),
                    TextFormField(
                       validator: (value) {
                         return (value?.isEmpty ?? true) ? 'Nama outlet laundry harus diisikan' : null;
                       },
                       onChanged: (value) {
                        prov.model?.name = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.name ?? ''),
                    ),
                    
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Alamat'),
                    TextFormField(
                      validator: (value) {
                         return (value?.isEmpty ?? true) ? 'Alamat outlet laundry harus diisikan' : null;
                       },
                      minLines: 2,
                      maxLines: 3,
                       onChanged: (value) {
                        prov.model?.address = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.address ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    
                    const Text('Kota'),
                    TextField( 
                      onChanged: (value) {
                        prov.model?.city = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.city ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                
                    const Text('Kecamatan'),
                    TextField( 
                      onChanged: (value) {
                        prov.model?.district = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.district ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                
                      const Text('Kelurahan'),
                    TextField( 
                      onChanged: (value) {
                        prov.model?.subdistrict = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.subdistrict ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                
                      const Text('Desa'),
                    TextField( 
                      onChanged: (value) {
                        prov.model?.village = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.village ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                
                    const Text('Nomor Telepon'),
                    TextField( 
                      onChanged: (value) {
                        prov.model?.phone = value;
                      },
                      controller:
                          TextEditingController(text: prov.model?.phone ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                
                
                
                
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
