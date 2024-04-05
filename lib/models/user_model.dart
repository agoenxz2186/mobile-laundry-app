import 'dart:convert';

class UserModel {
  int? id;
  String? idx;
  String? fullName;
  String? email;
  String? phone;
  dynamic dateBirth;
  String? gender;
  String? role;
  DateTime? createdAt;
  dynamic updatedAt;
  String? type;
  String? sessionId;

  UserModel({
    this.id,
    this.idx,
    this.fullName,
    this.email,
    this.phone,
    this.dateBirth,
    this.gender,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.sessionId,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        fullName: data['full_name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        dateBirth: data['date_birth'] as dynamic,
        gender: data['gender'] as String?,
        role: data['role'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] as dynamic,
        type: data['type'] as String?,
        sessionId: data['session_id'] as String?,
        id: data['id'],
        idx: data['idx'],
      );

  Map<String, dynamic> toMap() => {
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'date_birth': "$dateBirth",
        'gender': gender,
        'role': role,
        'type': type,
        'session_id': sessionId,
        'id': id,
        'idx': idx,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AuthModel] to a JSON string.
  String toJson() => json.encode(toMap());

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    dynamic dateBirth,
    String? gender,
    String? role,
    DateTime? createdAt,
    dynamic updatedAt,
    String? type,
    String? sessionId,
    int? id,
    String? idx,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateBirth: dateBirth ?? this.dateBirth,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      sessionId: sessionId ?? this.sessionId,
      id: id ?? this.id,
      idx: idx ?? this.idx,
    );
  }
}
