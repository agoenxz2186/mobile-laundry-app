 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/components/widgets.dart'; 
import 'package:laundry_owner/controllers/listproduk_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart'; 
import 'package:laundry_owner/models/product_model.dart';  
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart'; 

class ListProdukView extends StatelessWidget {
  final LaundryOutletModel? lo; 
  const ListProdukView(this.lo, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListProdukController());
    controller.clearItemSelected();

    return  Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Produk  / Jasa'),
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
                  title: 'Hapus Produk',
                  text: '${controller.itemSelected.keys.length} data produk akan dihapus, mau tetap dilanjutkan?',
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
              controller.newForm();
          },
          child: const Icon(MdiIcons.storeEdit),
        ),
        body: Obx( () {
            return SmartRefresher(
              controller: controller.refreshController,
              onLoading: () {
                controller.loadmore();
              },
              onRefresh: () {
                controller.loadrefresh();
              },
              child: ListView(
                children: [
                  if (controller.data.isEmpty)
                    const EmptyData()
                  else if(controller.isLoading.value == true)
                     const CupertinoActivityIndicator() 
                  else
                    for (ProductModel v in controller.data) 
                      _ItemListProduct(v: v, controller: controller,)
                ],
              ),
            );
          }
        ),
      ); 
  }
}

class _ItemListProduct extends StatelessWidget {
  const _ItemListProduct({
    super.key,
    required this.controller,
    required this.v,
  });

  final ProductModel v;
  final ListProdukController controller;

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
          
          title: Text('${v.name}', style: const TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
          trailing: Text('${v.rating ?? 0}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(v.category ?? "[Kategori belum di set]"),
              Text('${v.salePrice ?? 0} '),
              LabelInfo(label: Text('Layanan ${v.duration} ${v.durationUnit}'),)
            ],
          ),
        ); 
  }
}
