import 'dart:convert';

class OrderModel {
  int? id;
  String? orderAt;
  int? customerId;
  int? laundryOutletId;
  int? logUserId;
  String? subtotal;
  int? discountAmount;
  int? discountPercent;
  int? taxAmount;
  int? taxPercent;
  int? totalPrice;
  String? status;
  String? notesFromOutlet;
  int? pickerFee;
  int? deliveryFee;
  dynamic createdAt;
  dynamic updatedAt;
  String? customer;
  String? customerPhone;
  String? laundryOutlet;
  String? userLog;
  String? idx;

  OrderModel({
    this.id,
    this.orderAt,
    this.customerId,
    this.laundryOutletId,
    this.logUserId,
    this.subtotal,
    this.discountAmount,
    this.discountPercent,
    this.taxAmount,
    this.taxPercent,
    this.totalPrice,
    this.status,
    this.notesFromOutlet,
    this.pickerFee,
    this.deliveryFee,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.customerPhone,
    this.laundryOutlet,
    this.userLog,
    this.idx,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        id: data['id'] as int?,
        orderAt: data['order_at'] as String?,
        customerId: data['customer_id'] as int?,
        laundryOutletId: data['laundry_outlet_id'] as int?,
        logUserId: data['log_user_id'] as int?,
        subtotal: data['subtotal'] as String?,
        discountAmount: data['discount_amount'] as int?,
        discountPercent: data['discount_percent'] as int?,
        taxAmount: data['tax_amount'] as int?,
        taxPercent: data['tax_percent'] as int?,
        totalPrice: data['total_price'] as int?,
        status: data['status'] as String?,
        notesFromOutlet: data['notes_from_outlet'] as String?,
        pickerFee: data['picker_fee'] as int?,
        deliveryFee: data['delivery_fee'] as int?,
        createdAt: data['created_at'] as dynamic,
        updatedAt: data['updated_at'] as dynamic,
        customer: data['customer'] as String?,
        customerPhone: data['customer_phone'] as String?,
        laundryOutlet: data['laundry_outlet'] as String?,
        userLog: data['user_log'] as String?,
        idx: data['idx'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'order_at': orderAt,
        'customer_id': "$customerId",
        'laundry_outlet_id': "$laundryOutletId",
        'subtotal': "$subtotal",
        'discount_amount': "$discountAmount",
        'discount_percent': "$discountPercent",
        'tax_amount': "$taxAmount",
        'tax_percent': "$taxPercent",
        'total_price': "$totalPrice",
        'status': status,
        'notes_from_outlet': notesFromOutlet,
        'picker_fee': "$pickerFee",
        'delivery_fee': "$deliveryFee",
        'customer': customer,
        'customer_phone': customerPhone,
        'laundry_outlet': laundryOutlet,
        'user_log': userLog,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderModel].
  factory OrderModel.fromJson(String data) {
    return OrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
