// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromJson(jsonString);

import 'dart:convert';

OtpVerificationResponse otpVerificationResponseFromJson(String str) => OtpVerificationResponse.fromJson(json.decode(str));

String otpVerificationResponseToJson(OtpVerificationResponse data) => json.encode(data.toJson());

class OtpVerificationResponse {
  String message;
  User user;

  OtpVerificationResponse({
    required this.message,
    required this.user,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) => OtpVerificationResponse(
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String auth_token;
  String phoneNumber;
  String status;
  Profile profile;
  Wallet wallet;

  User({
    required this.id,
    required this.auth_token,
    required this.phoneNumber,
    required this.status,
    required this.profile,
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    auth_token: json["auth_token"],
    phoneNumber: json["phone_number"],
    status: json["status"],
    profile: Profile.fromJson(json["profile"]),
    wallet: Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "auth_token": auth_token,
    "phone_number": phoneNumber,
    "status": status,
    "profile": profile.toJson(),
    "wallet": wallet.toJson(),
  };
}

class Profile {
  int profileId;
  String name;
  String? email;
  String? profileImage;
  DateTime dateOfBirth;

  Profile({
    required this.profileId,
    required this.name,
    this.email,
    this.profileImage,
    required this.dateOfBirth,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    profileId: json["profile_id"],
    name: json["name"],
    email: json["email"],
    profileImage: json["profile_image"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "name": name,
    "email": email,
    "profile_image": profileImage,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
  };
}

class Wallet {
  int walletId;
  double balanceAmount;

  Wallet({
    required this.walletId,
    required this.balanceAmount,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    walletId: json["wallet_id"],
    balanceAmount: json["balance_amount"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "balance_amount": balanceAmount,
  };
}
