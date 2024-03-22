import 'dart:convert';

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? productCategoryId;
  int? dppPrice;
  int? salePrice;
  String? rating;
  String? duration;
  String? durationUnit;
  String? minimumQty;
  dynamic qty;
  dynamic qtyUnit;
  int? laundryOutletId;
  int? creatorUserId;
  String? idx;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.productCategoryId,
    this.dppPrice,
    this.salePrice,
    this.rating,
    this.duration,
    this.durationUnit,
    this.minimumQty,
    this.qty,
    this.qtyUnit,
    this.laundryOutletId,
    this.creatorUserId,
    this.idx,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        productCategoryId: data['product_category_id'] as int?,
        dppPrice: data['dpp_price'] as int?,
        salePrice: data['sale_price'] as int?,
        rating: data['rating'] as String?,
        duration: data['duration'] as String?,
        durationUnit: data['duration_unit'] as String?,
        minimumQty: data['minimum_qty'] as String?,
        qty: data['qty'] as dynamic,
        qtyUnit: data['qty_unit'] as dynamic,
        laundryOutletId: data['laundry_outlet_id'] as int?,
        creatorUserId: data['creator_user_id'] as int?,
        idx: data['idx'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'name': "$name",
        'description': "$description",
        'product_category_id': "$productCategoryId",
        'dpp_price': "$dppPrice",
        'sale_price': "$salePrice",
        'rating': "$rating",
        'duration': "$duration",
        'duration_unit': "$durationUnit",
        'minimum_qty': "$minimumQty",
        'qty': "$qty",
        'qty_unit': "$qtyUnit",
        'laundry_outlet_id': "$laundryOutletId",
        'creator_user_id': "$creatorUserId",
        'idx': "$idx",
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
