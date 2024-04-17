import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/controllers/listpelanggan_controller.dart';
import 'package:laundry_owner/models/customer_model.dart';
import 'package:laundry_owner/views/pelanggan/formpelanggan_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';

class ListPelangganView extends StatelessWidget {
  const ListPelangganView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListPelangganController());
    
    return Scaffold(
       appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Daftar Pelanggan'),
              Obx( () {
                  return controller.modeSelected.value ? 
                       DefaultTextStyle(
                        style: const TextStyle(fontSize: 13), 
                        child:   Text('Dipilih ${controller.itemSelected.keys.length}')
                      ) : const SizedBox.shrink();
                }
              )
            ],
          ),
          actions: [
            Obx(() => controller.modeSelected.value ? Row(children: [
              IconButton(onPressed: (){
                 QuickAlert.show(context: context, type: QuickAlertType.confirm,
                  title: 'Hapus Pelanggan',
                  text: '${controller.itemSelected.keys.length} data Pelanggan akan dihapus, mau tetap dilanjutkan?',
                  onCancelBtnTap: (){
                      Get.close(0);
                  },
                  onConfirmBtnTap: () {
                    controller.hapusData();
                  },
                 );
                
              }, icon: const Icon(Icons.delete)),
              IconButton(onPressed: (){
                  controller.clearItemSelected();
              }, icon: const Icon(Icons.close))
            ],) : const SizedBox.shrink())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const FormPelangganView()))
                .then((value) {
              if (value == true) controller.loadRefresh();
            });
          },
          child: const Icon(MdiIcons.storeEdit),
        ),
      body: Obx( () {
          return SmartRefresher(controller: controller.refreshController,
            onRefresh: () {
              controller.loadRefresh();
            },
            onLoading: () {
              controller.loadMore();
            },
            child: ListView(
              children: [
                for(var n in controller.data)
                 _ItemPelanggan(n: n, controller: controller,)
              ],
            ),
          );
        }
      )
    );
  }
}

class _ItemPelanggan extends StatelessWidget {
  const _ItemPelanggan({
    super.key,
    required this.controller,
    required this.n,
  });

  final CustomerModel n;
  final ListPelangganController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
       selected: controller.itemSelected[n.idx] == 1,
           selectedColor: Colors.green,
           onLongPress: () {
              controller.modeSelected.value = true;
              controller.addItemSelected('${n.idx}');
          },
          onTap: (){
              controller.onItemTap(n);
          },
     title: Text('${n.name}'),
     subtitle: Text('${n.phone}'),
    );
  }
}