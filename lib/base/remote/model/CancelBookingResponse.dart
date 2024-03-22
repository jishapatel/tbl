// To parse this JSON data, do
//
//     final cancelBookingsResponse = cancelBookingsResponseFromJson(jsonString);

import 'dart:convert';

CancelBookingsResponse cancelBookingsResponseFromJson(String str) => CancelBookingsResponse.fromJson(json.decode(str));

String cancelBookingsResponseToJson(CancelBookingsResponse data) => json.encode(data.toJson());

class CancelBookingsResponse {
  String? message;
  Booking? booking;

  CancelBookingsResponse({
    this.message,
    this.booking,
  });

  factory CancelBookingsResponse.fromJson(Map<String, dynamic> json) => CancelBookingsResponse(
    message: json["message"],
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "booking": booking?.toJson(),
  };
}

class Booking {
  String? status;
  int? id;
  int? userId;
  int? noOfPeople;
  DateTime? bookingDate;
  String? bookingAreaType;
  int? restaurantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic amount;
  int? bookingFloor;

  Booking({
    this.status,
    this.id,
    this.userId,
    this.noOfPeople,
    this.bookingDate,
    this.bookingAreaType,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.bookingFloor,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    status: json["status"],
    id: json["id"],
    userId: json["user_id"],
    noOfPeople: json["no_of_people"],
    bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
    bookingAreaType: json["booking_area_type"],
    restaurantId: json["restaurant_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    amount: json["amount"],
    bookingFloor: json["booking_floor"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "id": id,
    "user_id": userId,
    "no_of_people": noOfPeople,
    "booking_date": bookingDate?.toIso8601String(),
    "booking_area_type": bookingAreaType,
    "restaurant_id": restaurantId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "amount": amount,
    "booking_floor": bookingFloor,
  };
}
