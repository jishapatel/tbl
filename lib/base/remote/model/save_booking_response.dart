// To parse this JSON data, do
//
//     final saveBookingDetailsResponse = saveBookingDetailsResponseFromJson(jsonString);

import 'dart:convert';

SaveBookingDetailsResponse saveBookingDetailsResponseFromJson(String str) => SaveBookingDetailsResponse.fromJson(json.decode(str));

String saveBookingDetailsResponseToJson(SaveBookingDetailsResponse data) => json.encode(data.toJson());

class SaveBookingDetailsResponse {
  String? message;
  Booking? booking;

  SaveBookingDetailsResponse({
    this.message,
    this.booking,
  });

  factory SaveBookingDetailsResponse.fromJson(Map<String, dynamic> json) => SaveBookingDetailsResponse(
    message: json["message"],
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "booking": booking?.toJson(),
  };
}

class Booking {
  int? id;
  int? userId;
  int? noOfPeople;
  DateTime? bookingDate;
  String? bookingAreaType;
  int? restaurantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  double? amount;
  int? bookingFloor;

  Booking({
    this.id,
    this.userId,
    this.noOfPeople,
    this.bookingDate,
    this.bookingAreaType,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.amount,
    this.bookingFloor,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    userId: json["user_id"],
    noOfPeople: json["no_of_people"],
    bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
    bookingAreaType: json["booking_area_type"],
    restaurantId: json["restaurant_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    status: json["status"],
    amount: json["amount"],
    bookingFloor: json["booking_floor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "no_of_people": noOfPeople,
    "booking_date": bookingDate?.toIso8601String(),
    "booking_area_type": bookingAreaType,
    "restaurant_id": restaurantId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
    "amount": amount,
    "booking_floor": bookingFloor,
  };
}
