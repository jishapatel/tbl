// To parse this JSON data, do
//
//     final slotAvailabilityResponse = slotAvailabilityResponseFromJson(jsonString);

import 'dart:convert';

SlotAvailabilityResponse slotAvailabilityResponseFromJson(String str) =>
    SlotAvailabilityResponse.fromJson(json.decode(str));

String slotAvailabilityResponseToJson(SlotAvailabilityResponse data) =>
    json.encode(data.toJson());

class SlotAvailabilityResponse {
  int restaurantId;
  int totalBookings;
  int maximumAllowedBookings;

  SlotAvailabilityResponse({
    required this.restaurantId,
    required this.totalBookings,
    required this.maximumAllowedBookings,
  });

  factory SlotAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      SlotAvailabilityResponse(
        restaurantId: json["restaurant_id"],
        totalBookings: json["total_bookings"],
        maximumAllowedBookings: json["maximum_allowed_bookings"],
      );

  Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "total_bookings": totalBookings,
        "maximum_allowed_bookings": maximumAllowedBookings,
      };
}
