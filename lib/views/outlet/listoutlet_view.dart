import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/controllers/listoutlet_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart'; 
import 'package:laundry_owner/views/outlet/formoutlet_view.dart'; 
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';

class ListOutletView extends StatelessWidget {
  const ListOutletView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListOutletController());
    controller.clearItemSelected();

    return  Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Outlet Laundry'),
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
                  title: 'Hapus Outlet',
                  text: '${controller.itemSelected.keys.length} data outlet akan dihapus, mau tetap dilanjutkan?',
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
                    MaterialPageRoute(builder: (c) => const FormOutletView()))
                .then((value) {
              if (value == true) controller.refresh();
            });
          },
          child: const Icon(MdiIcons.storeEdit),
        ),
        body: SmartRefresher(
              controller: controller.refreshController,
              onLoading: () {
                controller.loadmore();
              },
              onRefresh: () {
                controller.refresh();
              },
              child: ListView(
                children: [
                  Obx(()=>Column(
                    children: [
                       if (controller.data.isEmpty)
                          const EmptyData()
                      else
                          for (LaundryOutletModel v in controller.data) 
                            _ItemListLaundryOutlet(v: v, controller: controller,)
                            
                    ],
                  ))
                ],
              ),
            ) 
      ); 
  }
}

class _ItemListLaundryOutlet extends StatelessWidget {
  const _ItemListLaundryOutlet({
    super.key,
    required this.controller,
    required this.v,
  });

  final LaundryOutletModel v;
  final ListOutletController controller;

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
          leading: Image.network(
            v.icon(),
            errorBuilder: (context, error, stackTrace) {
              return const Icon(MdiIcons.store, size: 38,color: Colors.grey,);
            },
          ),
          title: Text('${v.name}', style: const TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${v.address}, ${v.city ?? ''} ${v.district ?? ''}'),
              Text('${v.phone}')
            ],
          ),
        );
     
  }
}
