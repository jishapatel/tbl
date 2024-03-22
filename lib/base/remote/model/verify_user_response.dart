// To parse this JSON data, do
//
//     final verifyUserResponse = verifyUserResponseFromJson(jsonString);

import 'dart:convert';

VerifyUserResponse verifyUserResponseFromJson(String str) =>
    VerifyUserResponse.fromJson(json.decode(str));

String verifyUserResponseToJson(VerifyUserResponse data) =>
    json.encode(data.toJson());

class VerifyUserResponse {
  VerifyUserResponse({
    this.status,
    this.errorMessage,
    this.token,
    this.expiryTime,
    this.userRequestInfo,
  });

  String? status;
  String? errorMessage;
  String? token;
  int? expiryTime;
  List<UserRequestInfo>? userRequestInfo;

  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) =>
      VerifyUserResponse(
        status: json["status"],
        errorMessage: json["errorMessage"],
        token: json["Token"],
        expiryTime: json["expiryTime"],
        userRequestInfo: json["userRequestInfo"] == null ? null : List<
            UserRequestInfo>.from(
            json["userRequestInfo"].map((x) => UserRequestInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "errorMessage": errorMessage,
        "Token": token,
        "expiryTime": expiryTime,
        "userRequestInfo": List<dynamic>.from(
            userRequestInfo!.map((x) => x.toJson())),
      };
}

class UserRequestInfo {
  UserRequestInfo({
    this.userMobile,
    this.userType,
    this.errorMsg,
    this.isUserExist,
  });

  String? userMobile;
  String? userType;
  String? errorMsg;
  bool? isUserExist;

  factory UserRequestInfo.fromJson(Map<String, dynamic> json) =>
      UserRequestInfo(
        userMobile: json["userMobile"],
        userType: json["userType"],
        errorMsg: json["errorMsg"],
        isUserExist: json["isUserExist"],
      );

  Map<String, dynamic> toJson() =>
      {
        "userMobile": userMobile,
        "userType": userType,
        "errorMsg": errorMsg,
        "isUserExist": isUserExist,
      };
}
