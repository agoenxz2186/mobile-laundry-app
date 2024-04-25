import 'dart:convert';

class DetailOrderModel {
  int? id;
  int? orderId;
  int? productId;
  String? product;
  String? estimateFinish;
  double? qty;
  String? qtyUnit;
  double? priceSale;
  double? dppAmount;
  double? totalPrice;
  String? queueAt;
  dynamic washAt;
  dynamic dryAt;
  dynamic ironingAt;
  dynamic wrappingAt;
  String? notes;
  dynamic createdAt;
  dynamic updatedAt;

  DetailOrderModel({
    this.id,
    this.orderId,
    this.productId,
    this.estimateFinish,
    this.qty,
    this.qtyUnit,
    this.priceSale,
    this.dppAmount,
    this.totalPrice,
    this.queueAt,
    this.washAt,
    this.dryAt,
    this.ironingAt,
    this.wrappingAt,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory DetailOrderModel.fromMap(Map<String, dynamic> data) {
    return DetailOrderModel(
      id: data['id'] as int?,
      orderId: data['order_id'] as int?,
      productId: data['product_id'] as int?,
      estimateFinish: data['estimate_finish'] as String?,
      qty: double.tryParse('${data['qty']}'),
      product: data['product'] as String?,
      qtyUnit: data['qty_unit'] as String?,
      priceSale: double.tryParse('${data['price_sale']}'), //data['price_sale'] as String?,
      dppAmount: double.tryParse('${data['dpp_amount']}'), //data['dpp_amount'] as String?,
      totalPrice: double.tryParse('${data['total_price']}'), // data['total_price'] as String?,
      queueAt: data['queue_at'] as String?,
      washAt: data['wash_at'] as dynamic,
      dryAt: data['dry_at'] as dynamic,
      ironingAt: data['ironing_at'] as dynamic,
      wrappingAt: data['wrapping_at'] as dynamic,
      notes: data['notes'] as String?,
      createdAt: data['created_at'] as dynamic,
      updatedAt: data['updated_at'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'order_id': "$orderId",
        'product_id': "$productId",
        'estimate_finish': "$estimateFinish",
        'qty': qty,
        'qty_unit': "$qtyUnit",
        'price_sale': priceSale,
        'dpp_amount': dppAmount,
        'total_price': totalPrice,
        'queue_at': "$queueAt",
        'wash_at': "$washAt",
        'dry_at': "$dryAt",
        'ironing_at': "$ironingAt",
        'wrapping_at': "$wrappingAt",
        'notes': "$notes",
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DetailOrderModel].
  factory DetailOrderModel.fromJson(String data) {
    return DetailOrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DetailOrderModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
