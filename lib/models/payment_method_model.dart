import 'dart:convert';

class PaymentMethodModel {
  int? id;
  String? name;
  String? laundryOutlet;
  dynamic logo;
  int? laundryOutletId;
  int? creatorUserId;
  String? description;
  String? bank;
  String? accountNo;
  bool? isActive;
  String? idx;

  PaymentMethodModel({
    this.id,
    this.name,
    this.logo,
    this.laundryOutletId,
    this.laundryOutlet,
    this.creatorUserId,
    this.description,
    this.bank,
    this.accountNo,
    this.isActive,
    this.idx,
  });

  factory PaymentMethodModel.fromMap(Map<String, dynamic> data) {
    return PaymentMethodModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      laundryOutlet: data['laundry_outlet'] as String?,
      logo: data['logo'] as dynamic,
      laundryOutletId: data['laundry_outlet_id'] as int?,
      creatorUserId: data['creator_user_id'] as int?,
      description: data['description'] as String?,
      bank: data['bank'] as String?,
      accountNo: data['account_no'] as String?,
      isActive: data['is_active'] as bool?,
      idx: data['idx'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'logo': logo,
        'laundry_outlet_id': laundryOutletId,
        'laundry_outlet': laundryOutlet,
        'creator_user_id': creatorUserId,
        'description': description,
        'bank': bank,
        'account_no': accountNo,
        'is_active': isActive,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaymentMethodModel].
  factory PaymentMethodModel.fromJson(String data) {
    return PaymentMethodModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaymentMethodModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
