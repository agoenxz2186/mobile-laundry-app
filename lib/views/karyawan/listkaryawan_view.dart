import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/controllers/listkaryawan_controller.dart'; 
import 'package:laundry_owner/models/user_model.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/views/karyawan/formkaryawan_view.dart';  
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';

class ListKaryawanView extends StatelessWidget {
  const ListKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListKaryawanController());

    return  Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Daftar Karyawan'),
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
                  title: 'Hapus Karyawan',
                  text: '${controller.itemSelected.keys.length} data Karyawan akan dihapus, mau tetap dilanjutkan?',
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
                    MaterialPageRoute(builder: (c) => const FormKaryawanView()))
                .then((value) {
              if (value == true) controller.loadRefresh();
            });
          },
          child: const Icon(MdiIcons.storeEdit),
        ),
        body: Obx( () {
            logD(controller.data);
            return SmartRefresher(
                  controller: controller.refreshController,
                  onLoading: () {
                    controller.loadMore();
                  },
                  onRefresh: () {
                    controller.loadRefresh();
                  },
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          if(controller.isLoading.value == true)
                            const CupertinoActivityIndicator(),

                           if (controller.data.isEmpty)
                              const EmptyData()
                          else
                              for (UserModel v in controller.data) 
                                _itemListTile(v: v, controller: controller,)
                                
                        ],
                      )
                    ],
                  ),
                );
          }
        ) 
      ); 
  }
}

class _itemListTile extends StatelessWidget {
  const _itemListTile({ 
    required this.controller,
    required this.v,
  });

  final UserModel v;
  final ListKaryawanController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
           selected: controller.itemSelected[v.idx] == 1,
           selectedColor: Colors.green,
           onLongPress: () {
              controller.modeSelected.value = true;
              controller.addItemSelected(v.idx);
          },
          onTap: (){
              controller.onItemTap(v);
          },
          
          title: Text('${v.fullName}', style: const TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${v.gender ?? '-'}, ${v.roleAlias()}'),
              Text('${v.phone}')
            ],
          ),
        );
     
  }
}
