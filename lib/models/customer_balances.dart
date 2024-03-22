import 'dart:convert';

class CustomerBalances {
  int? id;
  String? transactionAt;
  int? customerId;
  int? laundryOutletId;
  String? category;
  String? amount;
  String? description;
  String? notes;
  String? idx;
  int? creatorUserId;

  CustomerBalances({
    this.id,
    this.transactionAt,
    this.customerId,
    this.laundryOutletId,
    this.category,
    this.amount,
    this.description,
    this.notes,
    this.creatorUserId,
    this.idx,
  });

  factory CustomerBalances.fromMap(Map<String, dynamic> data) {
    return CustomerBalances(
      id: data['id'] as int?,
      transactionAt: data['transaction_at'] as String?,
      customerId: data['customer_id'] as int?,
      laundryOutletId: data['laundry_outlet_id'] as int?,
      category: data['category'] as String?,
      amount: data['amount'] as String?,
      description: data['description'] as String?,
      notes: data['notes'] as String?,
      idx: data['idx'] as String?,
      creatorUserId: data['creator_user_id'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'transaction_at': "$transactionAt",
        'customer_id': "$customerId",
        'laundry_outlet_id': "$laundryOutletId",
        'category': category,
        'amount': "$amount",
        'description': description,
        'notes': notes,
        'creator_user_id': "$creatorUserId",
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CustomerBalances].
  factory CustomerBalances.fromJson(String data) {
    return CustomerBalances.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CustomerBalances] to a JSON string.
  String toJson() => json.encode(toMap());
}
