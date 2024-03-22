class AppEndpoint {
  AppEndpoint._();

  static const String appName = "TBL";

  /// api base url
  static const String baseUrl = "https://api.thebeerlibrary.in/";

  static const String verifyUser = "verifyUser";
  static const String signIn = "users/sign_in";
  static const String signUp = "users";
  static const String home = "homes/home_banners";
  static const String otpVerification = "users/verify_otp";
  static const String resendOtpVerification = "users/resend_otp";
  static const String getUserDetails = "users/get_details";
  static const String saveUserDetails = "profiles/update_profile";
  static const String walletAmount = "users/user_wallet";
  static const String walletHistories = "wallets/wallet_histories";
  static const String bookings = "bookings";
  static const String cancelBookings = "bookings/cancel_booking";
  static const String slotAvailability = "restaurants/slot_availability";
  static const String deActivateAccount = "users/deactivate_user";
  static const String deleteAccount = "users/delete_user";
  static const String billing = "\$id/billings";
}
