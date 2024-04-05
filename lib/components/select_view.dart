import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart'; 
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/utils/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef OnItemRender = Widget Function(dynamic n);
typedef OnAddNewTap = Function(dynamic n);

class SelectField extends StatelessWidget {
  const SelectField({super.key, this.controller, 
    this.onAddNewTap,
    this.title,
    this.url,
    this.onChanged,
    this.onItemRender,
    this.validator,
    this.label});

  final Widget? label; 
  final FormFieldValidator? validator;
  final String? title;
  final String? url;
  final OnAddNewTap? onAddNewTap;
  final OnItemRender? onItemRender;
  final TextEditingController? controller;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        label ?? const SizedBox.shrink(),
        InkWell(
          onTap: (){
              Get.to(()=>SelectView(title: title ?? 'Pilih Referensi',
                url: url,
                onAddNewTap: onAddNewTap,
                onItemRender: onItemRender,
              ))?.then((value) {
                  if(value != null){
                      if(onChanged != null){
                        logD('select nih : $value');
                          onChanged!(value);
                      }
                  }
              });
          },
          child: TextFormField(
              controller: controller,
              enabled: false,
              validator: validator ,
              decoration: const InputDecoration(
                  suffixIcon: Icon(MdiIcons.chevronDown)
              ),
              onTap: () {
                 
              },
          ),
        )
      ],
    );
  }
}
class SelectView extends StatelessWidget {
  const SelectView({super.key, 
    this.title = 'Pilih Referensi', this.onItemRender, this.url,
    this.onAddNewTap  
  });
  final OnAddNewTap? onAddNewTap;
  final String title;
  final String? url;
  final OnItemRender? onItemRender;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_SelectController());
    controller.init(url);

    return PopScope(
      onPopInvoked: (didPop) {
           
          if( didPop ){
             controller.pop();
          }
      },
      child: Scaffold(
        floatingActionButton: onAddNewTap == null ? null : 
          FloatingActionButton(onPressed: (){
              onAddNewTap!(controller);
          }, 
        tooltip: 'Tambah data', child: const Icon(MdiIcons.plus),),
        appBar: AppBar(title: Obx( () {
            return controller.isSearchMode.value == true ? CupertinoSearchTextField(
              style: const TextStyle(color: Colors.white),
              placeholderStyle: const TextStyle(color: Color.fromARGB(255, 204, 187, 167)),
              placeholder: 'Pencarian...',
              onSubmitted: (value) {
                  controller.keyword = value;
                  controller.loadRefresh();
              },
      
            ) : Text(title);
          }
        ),
          actions: [
              Obx(() => controller.isSearchMode.value == true ? IconButton(onPressed: (){
                 controller.isSearchMode.value = false; 
                 controller.keyword = '';            
              }, icon: const Icon(Icons.close)) : IconButton(onPressed: (){
                  controller.isSearchMode.value = true;
              }, icon: const Icon(Icons.search)) )
          ],
        ),
        body:  SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () {
                  controller.loadRefresh();
              },
              onLoading: () {
                  controller.loadMore();
              },
              child: ListView(children: [
      
                Obx( () => Column(
                  children: [
                      if(controller.data.isEmpty)
                        const EmptyData(
                          pesan: 'Belum ada data tersedia',
                        )
                      else
                        for(var n in controller.data)
                          if(onItemRender == null) 
                            const SizedBox()
                          else
                            InkWell(
                              onTap: (){
                                Get.back(result: n);
                              },
                              child: onItemRender!(n))
                  ],
                ))
                  
              ],),
            )
      ),
    );
  }
}

class _SelectController extends GetxController{
   String? _url;
   RefreshController refreshController = RefreshController(initialRefresh: true);
   RxList data = [].obs; 
   int _page = 1;
   String keyword = '';
   RxBool isLoading = false.obs;
   RxBool isSearchMode = false.obs;
   List _listURL = []; 

   void init(String? url){
      _listURL.add(url);
      _url = _listURL[ _listURL.length - 1 ];
      refreshController = RefreshController(initialRefresh: true);
      logD("isi url : ${_listURL}");
   }

   void pop(){
      _listURL.removeLast();
   }

   Future loadRefresh()async{
      _page = 1;
      _url = _listURL[ _listURL.length - 1 ];
      final uri = _url ?? '';
      isLoading.value = true;
      final r = await HTTP.get('$uri?page=$_page&keyword=$keyword');
      logD('$uri?page=$_page&keyword=$keyword');

      
      data.clear();
      if(r['code'] == 200){
          final dt =  r['json']['data'] ;
          data.addAll(dt);
          logD(dt);
      }

      isLoading.value = false;
      refreshController.refreshCompleted();
   }

   Future loadMore()async{
      _url = _listURL[ _listURL.length - 1 ];
      final uri = _url ?? '';
      _page++;
      isLoading.value = true;
      final r = await HTTP.get('$uri?page=$_page&keyword=$keyword');

      if(r['code'] == 200){
          final dt = r['json']['data'] as List;
          if(data.isNotEmpty){
              data.addAll( dt );
          }else{
              _page--;
          }
      }
      isLoading.value=false;
      refreshController.loadComplete();
   }
}