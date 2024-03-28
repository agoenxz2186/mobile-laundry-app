import 'dart:convert';

import 'package:laundry_owner/utils/url_address.dart';
import 'package:latlong2/latlong.dart';

class LaundryOutletModel {
  int? id;
  String? name;
  String? address;
  dynamic pointLocation;
  String? village;
  String? subdistrict;
  String? district;
  String? city;
  String? phone;
  String? email;
  dynamic web;
  int? ownerUserId;
  dynamic createdAt;
  dynamic updatedAt;
  String? owner;
  String? idx;

  LaundryOutletModel(
      {this.id,
      this.name,
      this.address,
      this.pointLocation,
      this.village,
      this.subdistrict,
      this.district,
      this.city,
      this.phone,
      this.email,
      this.web,
      this.ownerUserId,
      this.createdAt,
      this.updatedAt,
      this.owner,
      this.idx});

  factory LaundryOutletModel.fromMap(Map<String, dynamic> data) {
    return LaundryOutletModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      address: data['address'] as String?,
      pointLocation: data['point_location'] as dynamic,
      village: data['village'] as String?,
      subdistrict: data['subdistrict'] as String?,
      district: data['district'] as String?,
      city: data['city'] as String?,
      phone: data['phone'] as String?,
      email: data['email'] as String?,
      web: data['web'] as dynamic,
      ownerUserId: data['owner_user_id'] as int?,
      createdAt: data['created_at'] as dynamic,
      updatedAt: data['updated_at'] as dynamic,
      owner: data['owner'] as String?,
      idx: data['idx'] as String?,
    );
  }

  String icon(){
    return '${URLAddress.laundryOutlets}/icon/$idx.png';
  }

  LatLng? getPosition(){
    if(pointLocation == null)return null;
    if(pointLocation == '')return null;
    final spl = pointLocation.toString().split(',');
    if(spl.length < 2)return null;
    return LatLng( double.tryParse( spl[0] ) ?? 0, double.tryParse( spl[1] ) ?? 0 );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'point_location': pointLocation,
        'village': village,
        'subdistrict': subdistrict,
        'district': district,
        'city': city,
        'phone': phone,
        'email': email,
        'web': web,
        'owner_user_id': "$ownerUserId",
        'owner': "$owner",
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LaundryOutletModel].
  factory LaundryOutletModel.fromJson(String data) {
    return LaundryOutletModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LaundryOutletModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
