// To parse this JSON data, do
//
//     final walletAmountResponse = walletAmountResponseFromJson(jsonString);

import 'dart:convert';

WalletAmountResponse walletAmountResponseFromJson(String str) => WalletAmountResponse.fromJson(json.decode(str));

String walletAmountResponseToJson(WalletAmountResponse data) => json.encode(data.toJson());

class WalletAmountResponse {
  int? id;
  double? balanceAmount;
  int? userId;
  DateTime? openedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  WalletAmountResponse({
    this.id,
    this.balanceAmount,
    this.userId,
    this.openedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletAmountResponse.fromJson(Map<String, dynamic> json) => WalletAmountResponse(
    id: json["id"],
    balanceAmount: json["balance_amount"],
    userId: json["user_id"],
    openedAt: json["opened_at"] == null ? null : DateTime.parse(json["opened_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "balance_amount": balanceAmount,
    "user_id": userId,
    "opened_at": openedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
