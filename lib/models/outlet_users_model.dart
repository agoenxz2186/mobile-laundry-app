import 'dart:convert';

class OutletUsersModel {
  int? id;
  int? userId;
  int? laundryOutletId;
  bool? enabled;
  dynamic createdAt;
  dynamic updatedAt;
  String? user;
  String? role;
  String? laundryOutlet;
  String? address;
  String? idx;

  OutletUsersModel({
    this.id,
    this.userId,
    this.laundryOutletId,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.role,
    this.laundryOutlet,
    this.address,
    this.idx,
  });

  factory OutletUsersModel.fromMap(Map<String, dynamic> data) {
    return OutletUsersModel(
      id: data['id'] as int?,
      userId: data['user_id'] as int?,
      laundryOutletId: data['laundry_outlet_id'] as int?,
      enabled: data['enabled'] as bool?,
      createdAt: data['created_at'] as dynamic,
      updatedAt: data['updated_at'] as dynamic,
      user: data['user'] as String?,
      role: data['role'] as String?,
      laundryOutlet: data['laundry_outlet'] as String?,
      address: data['address'] as String?,
      idx: data['idx'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'user_id': "$userId",
        'laundry_outlet_id': "$laundryOutletId",
        'enabled': "$enabled",
        'user': user,
        'role': role,
        'laundry_outlet': laundryOutlet,
        'address': address,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OutletUsersModel].
  factory OutletUsersModel.fromJson(String data) {
    return OutletUsersModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OutletUsersModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
