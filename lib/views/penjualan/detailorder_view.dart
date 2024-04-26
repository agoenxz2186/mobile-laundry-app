import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/components/select_view.dart';
import 'package:laundry_owner/controllers/formdetailorder_controller.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/models/product_model.dart';
import 'package:laundry_owner/utils/text_formatter.dart';
import 'package:laundry_owner/utils/url_address.dart';

class DetailOrderView extends StatelessWidget {
  final LaundryOutletModel lo;
  const DetailOrderView(this.lo, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormDetailOrderController());
    controller.init(lo);

    return Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: controller.formKey,
                    child: Obx( () {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              const Text("Jasa / Produk:",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                              ),
                              Text('${lo.name}'),
                              const Divider(),
                              const SizedBox(height: 10,),
                              _pilihProduct(controller),
                              
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: _inputText(
                                      label: 'Qty',
                                      inputFormatters: [ 
                                          FilteringTextInputFormatter.allow( RegExp(r'^\d*.?\d{0,2}') )  ],
                                      value: '${controller.model.qty ?? 0}',
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        controller.model.qty = double.tryParse('$value') ?? 0;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(child: Text('${controller.productModel.qtyUnit}'))
                                ],
                              ),
                              
                          ],
                        );
                      }
                    ),
                  ),
                );
  }

  
  Widget _pilihProduct(FormDetailOrderController controller) {
    return  controller.loading.value ? const CupertinoActivityIndicator() : SelectField(
                label: const Text('Jasa / Produk'),
                validator: (value) => (value ?? '') == '' ? 'Produk / Jasa harus dipilih' : null,
                controller: controller.productText,
                title: 'Pilih Produk',
                url: '${URLAddress.products}/${lo.id}' ,
                onChanged: (value) => controller.setProduct(value),
                onItemRender: (n) {
                    final c = ProductModel.fromMap(n);
                    return ListTile(
                      leading: const Icon(MdiIcons.hanger),
                      title: Text('${c.name}',
                        style: const TextStyle(fontSize: 19),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${c.name}'),
                          Text('${c.duration} ${c.durationUnit}'),
                          Text('${c.category}')
                        ],
                      ),
                    );
                },
              ); 
  }

    Widget _inputText({
    String? value,
    String? label,
    String? teksIfEmpty,
    ValueChanged? onChanged,
    TextInputType? keyboardType,
    int? minLines, int? maxLines,
    bool readOnly = false,
    VoidCallback? onTap,
    List<TextInputFormatter>? inputFormatters
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
                  onTap: onTap,
                  readOnly: readOnly,
                  keyboardType: keyboardType,
                  minLines: minLines,
                  maxLines: maxLines,
                  inputFormatters: inputFormatters,
                  controller: TextEditingController(text: value),
                  validator: (value) {
                    return (value ?? '').isEmpty ? teksIfEmpty : null;
                  },
                  decoration: InputDecoration(
                    
                    label: Text('$label'), 
                  ),
                  onChanged: onChanged,
                ),
    );
  }

}