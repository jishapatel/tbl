import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_constant.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/utils/shared_pref_utils.dart';
import '../../base/widgets/appbar_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../navigation/navigation_screen.dart';
import 'otp_screen_bloc.dart';

class OtpScreen extends BasePage<OtpScreenBloc> {
  final String? key_mobileNumber;

  OtpScreen({super.key, this.key_mobileNumber});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _OtpScreenState();
  }

  static Route<dynamic> route(String? mobileNumber) {
    return CustomPageRoute(
        builder: (context) => OtpScreen(key_mobileNumber: mobileNumber));
  }
}

class _OtpScreenState extends BasePageState<OtpScreen, OtpScreenBloc> {
  _PinputExampleState pinputExampleState = _PinputExampleState();
  String pinCode = '';

  OtpScreenBloc bloc = OtpScreenBloc();
  bool isOtpFilled = false;
  bool isButtonDisabled = true;

  @override
  Widget? getAppBar() {
    return AppBarView(
      color: Colors.white,
      centerTitle: true,
      title: Text(
        'OTP',
        style: TextStyle(color: Colors.black), // Customize the title color
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black, // Customize the back icon color
        onPressed: () {
          // Implement the action on back icon press
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
      reverse: true,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                         SizedBox(height: 20.h),
                        Image.asset(
                          'assets/images/otp.png',
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.45,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          "Verification code",
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 47, 108),
                            fontFamily: 'Inter',
                          ),
                        ),
                         SizedBox(height: 15.h),
                        Text(
                          "We have sent the code verification to your mobile number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 47, 108),
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.key_mobileNumber.toString() ?? "",
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 47, 108),
                            //LIGHT_BLACK,
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(height: 22.h),
                        FractionallySizedBox(
                            widthFactor: 1,
                            child: PinputExample(
                                onChanged: onChanged,
                                onPinChanged: onChangedPin)),
                         SizedBox(height: 15.h),
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  onResendCode();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 48),
                                child: Text(
                                  "Resend OTP?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 47, 108, 1.0),
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: submitButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    )));
  }

  void onChanged(bool value) {
    setState(() {
      isOtpFilled = value;
    });
  }

  void onChangedPin(String value) {
    setState(() {
      pinCode = value;
    });
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 43, top: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOtpFilled
              ? Color.fromARGB(255, 255, 152, 0)
              : Color.fromARGB(255, 234, 234, 234),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 0,
        ),
        onPressed: isOtpFilled ? () => onButtonPressed() : null,
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            "Submit",
            style: TextStyle(
                fontSize: 20.sp,
                //fontWeight: FontWeight.w400,
                color: isOtpFilled
                    ? Colors.white
                    : Color.fromARGB(89, 2, 51, 126), //BLUE1,
                fontFamily: 'Inter'),
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
    hideKeyboard(context);
    Map? requestData;
    String otp = pinCode.trim();

    if (otp != null && widget.key_mobileNumber != null) {
      requestData = {
        OTP: otp,
        USER_MOBILE: widget.key_mobileNumber.toString(),
      };
    }

    getBloc().doOtpVerification(requestData, (response) {
      String message = response.message ?? "OK";
      if (message.contains("Otp Sent to") ||
          message.contains("Otp Verified Successfully")) {
        setBearerToken(response.user.auth_token);
        print(getBearerToken());
        setLogin(true);

        /// success
        setName(response.user.profile.name);
        setFName(response.user.profile.name);
        setUserID(response.user.id.toString());
        setProfilePic(response.user.profile.profileImage ?? "");

        // Navigator.pushAndRemoveUntil(context, NavigationScreen.route(),(route) => false,);
        Navigator.pushAndRemoveUntil(
          context,
          NavigationScreen.route(arguments: 0),
          (route) => false,
        );
      } else {
        /// error / version update
        showMessageBar(response.message ?? "");
      }
    });
  }

  void onResendCode() {
    hideKeyboard(context);
    Map? requestData;
    if (widget.key_mobileNumber != null) {
      String mobileNumber = widget.key_mobileNumber.toString();
      requestData = {"phone_number": mobileNumber};
    }

    getBloc().resendOtp(requestData, (response) {
      String message = response.message ?? "OK";
      if (message.contains("Otp Resend successfully")) {
        /// success
        showMessageBar(response.message ?? "");
      } else {
        /// error / version update
        showMessageBar(response.message ?? "");
      }
    });
  }

  @override
  OtpScreenBloc getBloc() {
    return bloc;
  }
}

class PinputExample extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final ValueChanged<String> onPinChanged; // Add this line

  const PinputExample(
      {Key? key, required this.onChanged, required this.onPinChanged})
      : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  // final formKey = GlobalKey<FormState>();

  void onChanged(String value) {
    setState(() {
      pinController.text = value;
    });

    final isOtpFilled = value.length == 4;
    widget.onChanged(isOtpFilled);
    widget.onPinChanged(value); // Add this line
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromARGB(255, 1, 28, 63);
    const borderColor = Colors.white12;
    double heigh = 0;
    if (MediaQuery.of(context).size.width > 600) {
      heigh = 73.h;
    }
    if (MediaQuery.of(context).size.width < 600) {
      heigh = 53.h;
    }
    final defaultPinTheme = PinTheme(
      width: 53.w,
      height: heigh,
      textStyle: TextStyle(
        fontSize: 19.sp,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 247, 255),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: borderColor),
      ),
    );

    debugPrint('pinController value: ${pinController.text}');

    return Form(
      // key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              validator: (value) {
                final isOtpFilled = value?.length == 4;
                widget.onChanged(isOtpFilled);
                return isOtpFilled ? null : 'Pin is incorrect';
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                final isOtpFilled = value.length == 4;
                widget.onChanged(isOtpFilled);
                widget
                    .onPinChanged(value); // Notify the parent about pin changes
              },
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
