// To parse this JSON data, do
//
//     final bookingsResponse = bookingsResponseFromJson(jsonString);

import 'dart:convert';

BookingsResponse bookingsResponseFromJson(String str) => BookingsResponse.fromJson(json.decode(str));

String bookingsResponseToJson(BookingsResponse data) => json.encode(data.toJson());

class BookingsResponse {
  List<Booking>? bookings;

  BookingsResponse({
    this.bookings,
  });

  factory BookingsResponse.fromJson(Map<String, dynamic> json) => BookingsResponse(
    bookings: json["bookings"] == null ? [] : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
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
  dynamic amount;
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
