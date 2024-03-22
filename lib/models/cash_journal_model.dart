import 'dart:convert';

class CashJournalModel {
  int? id;
  String? transAt;
  int? laundryOutletId;
  int? accountingNumberId;
  String? name;
  dynamic description;
  String? nominal;
  int? userId;
  dynamic createdAt;
  dynamic updatedAt;
  String? account;
  String? accountNo;
  String? idx;

  CashJournalModel({
    this.id,
    this.transAt,
    this.laundryOutletId,
    this.accountingNumberId,
    this.name,
    this.description,
    this.nominal,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.account,
    this.accountNo,
    this.idx,
  });

  factory CashJournalModel.fromMap(Map<String, dynamic> data) {
    return CashJournalModel(
      id: data['id'] as int?,
      transAt: data['trans_at'] as String?,
      laundryOutletId: data['laundry_outlet_id'] as int?,
      accountingNumberId: data['accounting_number_id'] as int?,
      name: data['name'] as String?,
      description: data['description'] as dynamic,
      nominal: data['nominal'] as String?,
      userId: data['user_id'] as int?,
      createdAt: data['created_at'] as dynamic,
      updatedAt: data['updated_at'] as dynamic,
      account: data['account'] as String?,
      accountNo: data['account_no'] as String?,
      idx: data['idx'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'trans_at': transAt,
        'laundry_outlet_id': "$laundryOutletId",
        'accounting_number_id': "$accountingNumberId",
        'name': name,
        'description': description,
        'nominal': "$nominal",
        'user_id': "$userId",
        'account': account,
        'account_no': accountNo,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CashJournalModel].
  factory CashJournalModel.fromJson(String data) {
    return CashJournalModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CashJournalModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
