import 'dart:convert';

class PickupDeliveryModel {
  int? id;
  int? orderId;
  int? detailOrderId;
  String? mode;
  String? startAppointment;
  String? endAppointment;
  String? address;
  String? point;
  String? notesFromCustomer;
  String? notesFromCourier;
  String? status;
  int? courierUserId;
  int? creatorCustomerId;
  int? creatorUserId;
  dynamic createdAt;
  dynamic updatedAt;

  PickupDeliveryModel({
    this.id,
    this.orderId,
    this.detailOrderId,
    this.mode,
    this.startAppointment,
    this.endAppointment,
    this.address,
    this.point,
    this.notesFromCustomer,
    this.notesFromCourier,
    this.status,
    this.courierUserId,
    this.creatorCustomerId,
    this.creatorUserId,
    this.createdAt,
    this.updatedAt,
  });

  factory PickupDeliveryModel.fromMap(Map<String, dynamic> data) {
    return PickupDeliveryModel(
      id: data['id'] as int?,
      orderId: data['order_id'] as int?,
      detailOrderId: data['detail_order_id'] as int?,
      mode: data['mode'] as String?,
      startAppointment: data['start_appointment'] as String?,
      endAppointment: data['end_appointment'] as String?,
      address: data['address'] as String?,
      point: data['point'] as String?,
      notesFromCustomer: data['notes_from_customer'] as String?,
      notesFromCourier: data['notes_from_courier'] as String?,
      status: data['status'] as String?,
      courierUserId: data['courier_user_id'] as int?,
      creatorCustomerId: data['creator_customer_id'] as int?,
      creatorUserId: data['creator_user_id'] as int?,
      createdAt: data['created_at'] as dynamic,
      updatedAt: data['updated_at'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id ?? "",
        'order_id': orderId ?? "",
        'detail_order_id': detailOrderId ?? "",
        'mode': mode ?? "",
        'start_appointment': startAppointment ?? "",
        'end_appointment': endAppointment ?? "",
        'address': address ?? "",
        'point': point ?? "",
        'notes_from_customer': notesFromCustomer ?? "",
        'notes_from_courier': notesFromCourier ?? "",
        'status': status ?? "",
        'courier_user_id': courierUserId ?? "",
        'creator_customer_id': creatorCustomerId ?? "",
        'creator_user_id': creatorUserId ?? "",
        'created_at': createdAt ?? "",
        'updated_at': updatedAt ?? "",
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PickupDeliveryModel].
  factory PickupDeliveryModel.fromJson(String data) {
    return PickupDeliveryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PickupDeliveryModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
