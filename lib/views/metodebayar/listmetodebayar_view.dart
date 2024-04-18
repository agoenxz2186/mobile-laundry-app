import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/controllers/listmetodebayar_controller.dart'; 
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/payment_method_model.dart';
import 'package:laundry_owner/views/metodebayar/formmetodebayar_view.dart'; 
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';

class ListMetodeBayarView extends StatelessWidget {
  final LaundryOutletModel lo;
  const ListMetodeBayarView({super.key, required this.lo});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListMetodeBayarController(lo));
    
    return Scaffold(
       appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Daftar Metode Pembayaran'),
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
                  title: 'Hapus Metode Bayar',
                  text: '${controller.itemSelected.keys.length} data Metode Pembayaran akan dihapus, mau tetap dilanjutkan?',
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
                    MaterialPageRoute(builder: (c) => FormMetodeBayarView(lo: lo,)))
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
                 _ItemData(n: n, controller: controller,)
              ],
            ),
          );
        }
      )
    );
  }
}

class _ItemData extends StatelessWidget {
  const _ItemData({
    super.key,
    required this.controller,
    required this.n,
  });

  final PaymentMethodModel n;
  final ListMetodeBayarController controller;

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
     subtitle: Text('${n.laundryOutlet}\n${n.bank} ${n.accountNo}',
      style: const TextStyle(fontSize: 12, color: Colors.grey),
     ),
    );
  }
}