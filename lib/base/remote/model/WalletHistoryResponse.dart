import 'dart:convert';

WalletHistoryResponse walletHistoryResponseFromJson(String str) => WalletHistoryResponse.fromJson(json.decode(str));

String walletHistoryResponseToJson(WalletHistoryResponse data) => json.encode(data.toJson());

class WalletHistoryResponse {
  List<WalletHistory>? walletHistories;

  WalletHistoryResponse({
    this.walletHistories,
  });

  factory WalletHistoryResponse.fromJson(Map<String, dynamic> json) => WalletHistoryResponse(
    walletHistories: json["wallet_histories"] == null ? [] : List<WalletHistory>.from(json["wallet_histories"]!.map((x) => WalletHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet_histories": walletHistories == null ? [] : List<dynamic>.from(walletHistories!.map((x) => x.toJson())),
  };
}

class WalletHistory {
  int? id;
  double? amount;
  double? earned_point;
  double? redeemed_point;
  String? status;
  int? walletId;
  DateTime? processedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  WalletHistory({
    this.id,
    this.amount,
    this.earned_point,
    this.redeemed_point,
    this.status,
    this.walletId,
    this.processedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
    id: json["id"],
        amount: json["amount"],
        earned_point: json["earned_point"],
        redeemed_point: json["redeemed_point"],
        status: json["status"],
        walletId: json["wallet_id"],
        processedAt: json["processed_at"] == null
            ? null
            : DateTime.parse(json["processed_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "amount": amount,
        "earned_point": earned_point,
        "redeemed_point": redeemed_point,
        "status": status,
        "wallet_id": walletId,
        "processed_at": processedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
