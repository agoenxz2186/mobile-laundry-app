import 'dart:convert';
import 'dart:ffi';

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? category;
  int? productCategoryId;
  double? dppPrice;
  double? salePrice;
  double? rating;
  double? duration;
  String? durationUnit;
  double? minimumQty;
  String? outletLaundry;
  dynamic qty;
  dynamic qtyUnit;
  int? laundryOutletId;
  int? creatorUserId;
  String? idx;
  bool? isAvailable;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.productCategoryId,
    this.dppPrice,
    this.salePrice,
    this.rating,
    this.duration,
    this.durationUnit,
    this.minimumQty,
    this.outletLaundry,
    this.qty,
    this.qtyUnit,
    this.laundryOutletId,
    this.creatorUserId,
    this.idx,
    this.isAvailable,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        category: data['category'] as String?,
        productCategoryId: data['product_category_id'] as int?,
        dppPrice: double.tryParse('${data['dpp_price']}'),
        salePrice: double.tryParse('${data['sale_price']}'), 
        rating: double.tryParse('${data['rating']}'),
        duration: double.tryParse('${data['duration']}') ?? 0,
        durationUnit: data['duration_unit'] as String?,
        minimumQty: double.tryParse('${data['minimum_qty']}'),
        qty: data['qty'] as dynamic,
        qtyUnit: data['qty_unit'] as dynamic,
        laundryOutletId: data['laundry_outlet_id'] as int?,
        creatorUserId: data['creator_user_id'] as int?,
        outletLaundry: data['outlet_laundry'],
        idx: data['idx'] as String?,
        isAvailable:bool.tryParse( '${data['is_available']}' ) ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': "$name",
        'description': "$description",
        'product_category_id': productCategoryId,
        'dpp_price': dppPrice ?? 0,
        'sale_price': salePrice ?? 0,
        'rating': rating ?? 0, 
        'duration': duration ?? 0,
        'duration_unit': durationUnit ?? 'jam',
        'minimum_qty': minimumQty ?? 0,
        'outlet_laundry': outletLaundry,
        'qty': qty ?? 0,
        'qty_unit': qtyUnit ?? 'pcs',
        'laundry_outlet_id': laundryOutletId,
        'creator_user_id': creatorUserId,
        'idx': "$idx",
        'is_available': isAvailable,
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
