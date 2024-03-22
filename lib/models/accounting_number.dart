import 'dart:convert';

class AccountingNumber {
  int? id;
  String? code;
  String? name;

  AccountingNumber({this.id, this.code, this.name});

  factory AccountingNumber.fromMap(Map<String, dynamic> data) {
    return AccountingNumber(
      id: data['id'] as int?,
      code: data['code'] as String?,
      name: data['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': "$id",
        'code': code,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AccountingNumber].
  factory AccountingNumber.fromJson(String data) {
    return AccountingNumber.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AccountingNumber] to a JSON string.
  String toJson() => json.encode(toMap());
}
