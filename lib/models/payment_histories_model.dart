import 'dart:convert';

class PaymentHistoriesModel {
  int? id;
  int? orderId;
  int? paymentMethodId;
  String? amount;
  String? notes;
  int? customerId;
  int? verifiedByUserId;
  dynamic verifyAt;
  dynamic photo;
  String? status;
  String? idx;
  dynamic createdAt;
  dynamic updatedAt;

  PaymentHistoriesModel({
    this.id,
    this.orderId,
    this.paymentMethodId,
    this.amount,
    this.notes,
    this.customerId,
    this.verifiedByUserId,
    this.verifyAt,
    this.photo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.idx,
  });

  factory PaymentHistoriesModel.fromMap(Map<String, dynamic> data) {
    return PaymentHistoriesModel(
      id: data['id'] as int?,
      orderId: data['order_id'] as int?,
      paymentMethodId: data['payment_method_id'] as int?,
      amount: data['amount'] as String?,
      notes: data['notes'] as String?,
      customerId: data['customer_id'] as int?,
      verifiedByUserId: data['verified_by_user_id'] as int?,
      verifyAt: data['verify_at'] as dynamic,
      photo: data['photo'] as dynamic,
      status: data['status'] as String?,
      createdAt: data['created_at'] as dynamic,
      updatedAt: data['updated_at'] as dynamic,
      idx: data['idx'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'order_id': "$orderId",
        'payment_method_id': "$paymentMethodId",
        'amount': "$amount",
        'notes': "$notes",
        'customer_id': "$customerId",
        'verified_by_user_id': "$verifiedByUserId",
        'verify_at': "$verifyAt",
        'photo': "$photo",
        'status': "$status",
        'idx': "$idx",
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaymentHistoriesModel].
  factory PaymentHistoriesModel.fromJson(String data) {
    return PaymentHistoriesModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaymentHistoriesModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
