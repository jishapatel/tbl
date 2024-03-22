

import '../../constants/app_endpoint.dart';
import '../../network/error/net_exception.dart';
import '../model/CancelBookingResponse.dart';
import '../model/ResendOTPResponse.dart';
import '../model/WalletHistoryResponse.dart';
import '../model/billing_details_response.dart';
import '../model/bookings_response.dart';
import '../model/common_response.dart';
import '../model/home_response.dart';
import '../model/otp_verification_response.dart';
import '../model/profile_response.dart';
import '../model/save_booking_response.dart';
import '../model/save_detail_response.dart';
import '../model/signin_response.dart';
import '../model/slot_availability_response.dart';
import '../model/verify_user_response.dart';
import '../model/wallet_amount_response.dart';
import '../net_manager.dart';

/// Login API
void apiVerifyUser(Map? data, Function(VerifyUserResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.verifyUser, params: data, isAuth: false)
      .then((value) {
    final response = verifyUserResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// SLOT AVAILABILITY API
void apiSlotAvailability(
    Map<String, dynamic>? data,
    Function(SlotAvailabilityResponse) onSuccess,
    Function(NetWorkException) onError,
    ) {
  get(AppEndpoint.slotAvailability, params: data).then(
        (value) {
      final response = slotAvailabilityResponseFromJson(value.toString());
      onSuccess(response);
    },
  ).catchError(
        (error) {
      if (error is NetWorkException) {
        onError(error);
      } else {
        onError(NetWorkException(101010, error.toString()));
      }
    },
  );
}

/// Home API
void apiHome(Map? data, Function(HomeResponse) onSuccess,
    Function(NetWorkException) onError) {
  get<String>(AppEndpoint.home, params: data).then((value) {
    final response = homeResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Booking Details API
void apiReservations(Map? data, Function(BookingsResponse) onSuccess,
    Function(NetWorkException) onError) {
  get<String>(AppEndpoint.bookings, params: data).then((value) {
    final response = bookingsResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Booking Details API
void apiCreateReservations(Map? data, Function(SaveBookingDetailsResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.bookings, params: data).then((value) {
    final response = saveBookingDetailsResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Cancel Booking Details API
void apiCancelBooking(Map? data, Function(CancelBookingsResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.cancelBookings, params: data).then((value) {
    final response = cancelBookingsResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Wallet history API
void apiWalletHistory(Map? data, Function(WalletHistoryResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.walletHistories, params: data).then((value) {
    final response = walletHistoryResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Wallet history API
void apiWalletAmount(Map? data, Function(WalletAmountResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.walletAmount, params: data).then((value) {
    final response = walletAmountResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Wallet details API
void apiWalletDetails(
    Map? data,
    String walletId,
    Function(BillingDetailsResponse) onSuccess,
    Function(NetWorkException) onError) {
  get("wallet_histories/$walletId/billings", params: data).then((value) {
    final response = billingDetailsResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
      //onError(error);
    }
  });
}

/// SignIn API
void apiSignIn(Map? data, Function(SignInResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.signIn, params: data).then((value) {
    final response = signInResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// SignUp API
void apiSignUp(Map? data, Function(SignInResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.signUp, params: data).then((value) {
    final response = signInResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// OTP VERIFICATION API
void apiOtpVerification(Map? data, Function(OtpVerificationResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.otpVerification, params: data).then((value) {
    final response = otpVerificationResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// Resend OTP API
void apiResendOtp(Map? data, Function(ResendOtpResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.resendOtpVerification, params: data).then((value) {
    final response = resendOtpResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// GET USER DETAILS API
void apiGetUserDetails(Function(UserDetails) onSuccess,
    Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getUserDetails,isAuth: true).then((value) {
    final response = userDetailsFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// DEACTIVATE ACCOUNT API
void apiDeActivateAccount(Function(CommonResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.deActivateAccount,isAuth: true).then((value) {
    final response = commonResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

///  DELETE USER API
void apiDeleteAccount(Function(CommonResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.deleteAccount,isAuth: true).then((value) {
    final response = commonResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// SAVE USER DETAILS API
void apiSaveUserDetails(params, Function(SaveUserDetail) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.saveUserDetails,isAuth: true, params: params).then((value) {
      final response = saveDetailsFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

/// GET WALLET HISTORY API
void apiGetWalletHistory(Map? data, Function(SignInResponse) onSuccess,
    Function(NetWorkException) onError) {
  post<String>(AppEndpoint.signIn, params: data).then((value) {
    final response = signInResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      onError(error);
    } else {
      onError(NetWorkException(101010, error.toString()));
    }
  });
}

//
// /// CONTACT US API
// void apiContactUs(Map? data, Function(ContactUsResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getContactNumbers, params: data).then((value) {
//     final response = contactUsResponseFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// /// TOKEN API
// void apiRefreshToken(Function(RefreshTokenResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getToken).then((value) {
//     final response = refreshTokenResponseFromJson(value!);
//     setBearerToken("Bearer ${response.token ?? ""}");
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// /// MASTER DATA API
// void apiMasterData(Map? data, Function(MasterDataResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getMaster, params: data).then((value) {
//     final response = masterDataResponseFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiGetServiceSite(Map? data, Function(ServiceSitesRespose) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getServiceSites, params: data).then((value) {
//     final response = serviceSitesResposeFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiGetProductList(Map? data, Function(GetProductResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getProducts, params: data).then((value) {
//     final response = getProductResponseFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiGetQuotesReceipt(
//     Map? data,
//     Function(GetQuotesReceiptResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getQuotesReceipt, params: data).then((value) {
//     final response = getQuotesReceiptResponseFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiCreateUser(Map? data, Function(CreateUserResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.createUpdateUser, params: data).then((value) {
//     final response = createUserResponseFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiCreateUpdateProduct(
//     Map? data,
//     Function(CreateProductResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.createUpdateProduct, params: data).then((value) {
//     final response = createProductResponseFromJson(value!);
//     onSuccess(response);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiCallRegister(Map? data, Function(CallRegisterResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.callRegister, params: data).then((value) {
//     final response = callRegisterResponseFromJson(value!);
//     onSuccess(response!);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiGetCall(Map? data, Function(GetCallsResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getCalls, params: data).then((value) {
//     final response = getCallsResponseFromJson(value!);
//     onSuccess(response!);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
//
// void apiGetOpenQuoteList(Map? data, Function(OpenQuoteListResponse) onSuccess,
//     Function(NetWorkException) onError) {
//   post<String>(AppEndpoint.getQuotes, params: data).then((value) {
//     final response = openQuoteListResponseFromJson(value!);
//     onSuccess(response!);
//   }).catchError((error) {
//     if (error is NetWorkException) {
//       onError(error);
//     } else {
//       onError(NetWorkException(101010, error.toString()));
//     }
//   });
// }
