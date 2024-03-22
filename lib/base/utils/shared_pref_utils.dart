import 'package:flutter/material.dart';
import 'package:tbl/base/utils/sp_util.dart';

import '../../screens/sign_in/signin_screen.dart';
import '../constants/app_widgets.dart';


const String keyLogin = "login";
const String keyWelcome = "welcome";
const String keyUserID = "userId";
const String keyUserType = "userType";
const String keyToken = "token";
const String keyBasicToken = "BasicToken";
const String keyBearerToken = "BearerToken";
const String keyMobileNumber = "MobileNumber";
const String keyBothAccount = "bothAccount";
const String keyName = "name";
const String keyProfilePic = "profilePic";

void onLogout() {
  setLogin(false);
  setToken("");
  setBearerToken("");
  setBasicToken("");
  setMobileNumber("");
  setUserID("");
  setUserType("");
  setBothAccount(false);
  Navigator.pushAndRemoveUntil(
      globalContext, SigninScreen.route(), (route) => false);
}

/// Login
void setLogin(bool isLogin) {
  SpUtil.putBool(keyLogin, isLogin);
}

bool isLogin() {
  return SpUtil.getBool(keyLogin, defValue: false);
}

/// Login
void setWelcomeShow(bool isWelcomeShow) {
  SpUtil.putBool(keyWelcome, isWelcomeShow);
}

bool isWelcomeShow() {
  return SpUtil.getBool(keyWelcome, defValue: false);
}

/// Bearer Token
void setBearerToken(String token) {
  SpUtil.putString(keyBearerToken, token);
}

String getBearerToken() {
  return SpUtil.getString(keyBearerToken, defValue: "");
}

/// Basic Token
void setBasicToken(String token) {
  SpUtil.putString(keyBasicToken, token);
}

String getBasicToken() {
  return SpUtil.getString(keyBasicToken, defValue: "");
}

/// Mobile Number
void setMobileNumber(String token) {
  SpUtil.putString(keyMobileNumber, token);
}

String getMobileNumber() {
  return SpUtil.getString(keyMobileNumber, defValue: "");
}

/// NAme
void setName(String name) {
  SpUtil.putString(keyName, name);
}

String getName() {
  return SpUtil.getString(keyName, defValue: "");
}

/// NAme
void setFName(String name) {
  SpUtil.putString(keyName, name);
}

String getFName() {
  return SpUtil.getString(keyName, defValue: "");
}

/// Profile Pic
void setProfilePic(String profilePic) {
  SpUtil.putString(keyProfilePic, profilePic);
}

String getProfilePic() {
  return SpUtil.getString(keyProfilePic, defValue: "");
}

/// User Id
void setUserID(String token) {
  SpUtil.putString(keyUserID, token);
}

String getUserID() {
  return SpUtil.getString(keyUserID, defValue: "");
}

/// User Type
void setUserType(String token) {
  SpUtil.putString(keyUserType, token);
}

String getUserType() {
  return SpUtil.getString(keyUserType, defValue: "");
}

/// Bearer Token
void setToken(String token) {
  SpUtil.putString(keyToken, token);
}

String getToken() {
  return SpUtil.getString(keyToken, defValue: "");
}

/// Both Accounts
void setBothAccount(bool isBothAccount) {
  SpUtil.putBool(keyBothAccount, isBothAccount);
}

bool isBothAccount() {
  return SpUtil.getBool(keyBothAccount, defValue: false);
}
