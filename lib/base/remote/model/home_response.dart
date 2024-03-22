// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  List<String> todaysLatestOffers;
  List<String> pastEvents;
  List<String> ourMenu;
  List<String> todaysOffer;
  List<String> upcomingEvents;

  HomeResponse({
    required this.todaysLatestOffers,
    required this.pastEvents,
    required this.ourMenu,
    required this.todaysOffer,
    required this.upcomingEvents,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    todaysLatestOffers: List<String>.from(json["todays_latest_offers"].map((x) => x)),
    pastEvents: List<String>.from(json["past_events"].map((x) => x)),
    ourMenu: List<String>.from(json["our_menu"].map((x) => x)),
    todaysOffer: List<String>.from(json["todays_offer"].map((x) => x)),
    upcomingEvents: List<String>.from(json["upcoming_events"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "todays_latest_offers": List<dynamic>.from(todaysLatestOffers.map((x) => x)),
    "past_events": List<dynamic>.from(pastEvents.map((x) => x)),
    "our_menu": List<dynamic>.from(ourMenu.map((x) => x)),
    "todays_offer": List<dynamic>.from(todaysOffer.map((x) => x)),
    "upcoming_events": List<dynamic>.from(upcomingEvents.map((x) => x)),
  };
}
