import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  int? id;
  String? phoneNumber;
  String? status;
  dynamic authToken;
  Profile? profile;
  Wallet? wallet;

  UserDetails({
    this.id,
    this.phoneNumber,
    this.status,
    this.authToken,
    this.profile,
    this.wallet,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    phoneNumber: json["phone_number"],
    status: json["status"],
    authToken: json["auth_token"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone_number": phoneNumber,
    "status": status,
    "auth_token": authToken,
    "profile": profile?.toJson(),
    "wallet": wallet?.toJson(),
  };
}

class Profile {
  int? profileId;
  String? name;
  dynamic email;
  String? profileImage;
  DateTime? dateOfBirth;

  Profile({
    this.profileId,
    this.name,
    this.email,
    this.profileImage,
    this.dateOfBirth,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    profileId: json["profile_id"],
    name: json["name"],
    email: json["email"],
    profileImage: json["profile_image"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "name": name,
    "email": email,
    "profile_image": profileImage,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
  };
}

class Wallet {
  dynamic walletId;
  dynamic balanceAmount;

  Wallet({
    this.walletId,
    this.balanceAmount,
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
