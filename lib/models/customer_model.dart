import 'dart:convert';

class CustomerModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? pointLocation;
  String? village;
  String? subdistrict;
  String? district;
  String? city;
  String? password;
  String? tokenReset;
  String? notes;
  String? totalExpense;
  String? idx;

  CustomerModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.pointLocation,
      this.village,
      this.subdistrict,
      this.district,
      this.city,
      this.password,
      this.tokenReset,
      this.notes,
      this.totalExpense,
      this.idx});

  factory CustomerModel.fromMap(Map<String, dynamic> data) => CustomerModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        address: data['address'] as String?,
        pointLocation: data['point_location'] as String?,
        village: data['village'] as String?,
        subdistrict: data['subdistrict'] as String?,
        district: data['district'] as String?,
        city: data['city'] as String?,
        password: data['password'] as String?,
        tokenReset: data['token_reset'] as String?,
        notes: data['notes'] as String?,
        totalExpense: data['total_expense'] as String?,
        idx: data['idx'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'name': name,
        'phone': phone,
        'address': address,
        'point_location': pointLocation,
        'village': village,
        'subdistrict': subdistrict,
        'district': district,
        'city': city,
        'password': password,
        'token_reset': tokenReset,
        'notes': notes,
        'total_expense': totalExpense,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CustomerModel].
  factory CustomerModel.fromJson(String data) {
    return CustomerModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CustomerModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
