import 'dart:convert';

class ProductCategoryModel {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  int? laundryOutletId;
  int? userId;
  String? laundryOutlet;
  String? user;
  String? idx;

  ProductCategoryModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.laundryOutletId,
    this.userId,
    this.laundryOutlet,
    this.user,
    this.idx,
  });

  factory ProductCategoryModel.fromMap(Map<String, dynamic> data) {
    return ProductCategoryModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      isActive: data['is_active'] as bool?,
      laundryOutletId: data['laundry_outlet_id'] as int?,
      userId: data['user_id'] as int?,
      laundryOutlet: data['laundry_outlet'] as String?,
      user: data['user'] as String?,
      idx: data['idx'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'name': name,
        'description': description,
        'is_active': "$isActive",
        'laundry_outlet_id': "$laundryOutletId",
        'user_id': "$userId",
        'laundry_outlet': laundryOutlet,
        'user': user,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductCategoryModel].
  factory ProductCategoryModel.fromJson(String data) {
    return ProductCategoryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductCategoryModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
