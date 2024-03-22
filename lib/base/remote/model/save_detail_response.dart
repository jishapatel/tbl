import 'dart:convert';

SaveUserDetail saveDetailsFromJson(String str) => SaveUserDetail.fromJson(json.decode(str));

String saveDetailsToJson(SaveUserDetail data) => json.encode(data.toJson());

class SaveUserDetail {
  int? userId;
  String? email;
  int? id;
  dynamic activatedAt;
  dynamic deactivatedAt;
  DateTime? openedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  DateTime? dateOfBirth;
  String? profileImage;

  SaveUserDetail({
    this.userId,
    this.email,
    this.id,
    this.activatedAt,
    this.deactivatedAt,
    this.openedAt,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.dateOfBirth,
    this.profileImage,
  });

  factory SaveUserDetail.fromJson(Map<String, dynamic> json) => SaveUserDetail(
    userId: json["user_id"],
    email: json["email"],
    id: json["id"],
    activatedAt: json["activated_at"],
    deactivatedAt: json["deactivated_at"],
    openedAt: json["opened_at"] == null ? null : DateTime.parse(json["opened_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "id": id,
    "activated_at": activatedAt,
    "deactivated_at": deactivatedAt,
    "opened_at": openedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "profile_image": profileImage,
  };
}
