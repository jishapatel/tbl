// To parse this JSON data, do
//
//     final billingItems = billingItemsFromJson(jsonString);

import 'dart:convert';

BillingItems billingItemsFromJson(String str) =>
    BillingItems.fromJson(json.decode(str));

String billingItemsToJson(BillingItems data) => json.encode(data.toJson());

class BillingItems {
  int id;
  String name;
  int qty;
  double price;
  String category;

  // double cgst;
  // double sgst;

  BillingItems({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
    required this.category,
    // required this.cgst,
    // required this.sgst,
  });

  factory BillingItems.fromJson(Map<String, dynamic> json) => BillingItems(
        id: json["id"],
        name: json["name"],
        qty: json["qty"],
        price: json["price"],
        category: json["category"],
        // cgst: json["cgst"],
        // sgst: json["sgst"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "qty": qty,
        "price": price,
        "category": category,
        // "cgst": cgst,
        // "sgst": sgst,
      };
}
