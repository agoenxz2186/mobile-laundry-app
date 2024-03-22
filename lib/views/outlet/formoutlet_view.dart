import 'package:flutter/material.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/providers/formoutlet_provider.dart';
import 'package:provider/provider.dart';

class FormOutletView extends StatelessWidget {
  final LaundryOutletModel? model;

  const FormOutletView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    context.read<FormOutletProvider>().init(model);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet'),
      ),
      body: SingleChildScrollView(
        child: Consumer<FormOutletProvider>(
          builder: (context, prov, child) => Form(
            key: prov.formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nama Outlet Laundry'),
                  TextField(
                    controller:
                        TextEditingController(text: prov.model?.name ?? ''),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Nama Outlet Laundry'),
                  TextField(
                    controller:
                        TextEditingController(text: prov.model?.name ?? ''),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
