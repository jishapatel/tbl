import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_constant.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/SizeConfig.dart';
import '../../base/widgets/custom_page_route.dart';
import '../otp/otp_screen.dart';
import '../signup_screen/signup_screen.dart';
import 'sign_in_screen_bloc.dart';

class SigninScreen extends BasePage<SignInScreenBloc> {
  SigninScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _SigninScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => SigninScreen());
  }
}

class _SigninScreenState extends BasePageState<SigninScreen, SignInScreenBloc> {
  SignInScreenBloc bloc = SignInScreenBloc();
  final TextEditingController _mobileNumberController = TextEditingController();

  final FocusNode _nodeMobileNumber = FocusNode();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValidPhoneNumber = false;
  bool _isEmpty = false;
  String number = "";

  @override
  void initState() {
    super.initState();
    _mobileNumberController.addListener(_validatePhone);
    _isEmpty = true;
  }

  void _validatePhone() {
    final String phone = _mobileNumberController.text.trim();
    final bool isValid = RegExp(r'^[0-9]{10}$').hasMatch(phone);
    setState(() {
      _isEmpty = phone.isEmpty;
      _isValidPhoneNumber = isValid;
    });
  }

  Widget welcomeBlock() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        reverse: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        if (MediaQuery.of(context).size.width > 600)
                          Image.asset(
                            'assets/images/rect.png',
                            width: MediaQuery.of(context).size.width,
                            height: SizeConfig.screenHeight * 1.5,
                            fit: BoxFit.fill,
                          ),
                        if (MediaQuery.of(context).size.width < 600)
                          Image.asset(
                            'assets/images/rect.png',
                            width: MediaQuery.of(context).size.width,
                            height: SizeConfig.screenHeight * 0.9,
                            fit: BoxFit.fill,
                          ),
                        SizedBox(height: 25.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 31.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 47, 108)),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context, SignUpScreen.route());
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Sign up",
                                            style: TextStyle(
                                              color: Color(0xff011c3f),
                                              fontSize: 23.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          //Icon(Icons.arrow_right_alt_rounded),
                                          SizedBox(width: 4.w),
                                          SvgPicture.asset(
                                            'assets/icons/back_right.svg',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                //'Let’s reserve table and earn exclusive points with TBL Loyalty Programme.',
                                'Join TBL family and earn exclusive points and learn about the special offers!',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    height: 1.5,
                                    fontFamily: 'Inter',
                                    color: Color.fromARGB(255, 1, 28, 63)),
                              ),
                              SizedBox(height: 10.h),
                              _mobileNumber(),
                            ],
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: _getFAB(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mobileNumber() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      key: _formKey,
      child: Container(
        child: TextField(
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 19.sp,
            color: Color.fromARGB(255, 42, 44, 49),
          ),
          controller: _mobileNumberController,
          focusNode: _nodeMobileNumber,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: InputDecoration(
            counterText: '',
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
              borderRadius: BorderRadius.circular(28.0.r),
            ),
            errorText: _isEmpty
                ? null
                : _isValidPhoneNumber
                    ? ""
                    : "Please input a valid mobile number",
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0.r),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 192, 192, 192),
                width: 0.5.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
              borderRadius: BorderRadius.circular(28.0.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
              borderRadius: BorderRadius.circular(28.0.r),
            ),
            //labelText: 'Mobile Number',
            //hintStyle: TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: 19.sp,
              color: Color.fromARGB(255, 192, 192, 192),
            ),
            hintText: "Mobile number",
            //prefixText: '+',
            prefixIcon: Container(
              margin: EdgeInsets.fromLTRB(27, 16, 0, 16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(
                  Icons.phone,
                  color: Color.fromARGB(255, 192, 192, 192),
                ),
              ),
            ),
            suffixIcon: _isEmpty
                ? null
                : _isValidPhoneNumber
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget _getFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 43, top: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: _isValidPhoneNumber
              ? Color.fromARGB(255, 255, 152, 0)
              : Color.fromARGB(255, 234, 234, 234),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
          elevation: 0,
        ),
        onPressed: onContinue,
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            "Continue",
            style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w500,
                color: _isValidPhoneNumber
                    ? Colors.white
                    : Color.fromARGB(89, 2, 51, 126), //BLUE1,
                fontFamily: 'Inter'),
          ),
        ),
      ),
    );
  }

  void onContinue() {
    hideKeyboard(context);
    String mobileNumber = "+91" + _mobileNumberController.text.trim();
    Map<String, dynamic> requestData = {USER_MOBILE: mobileNumber};

    getBloc().doLogin(requestData, (response) {
      String message = response.message ?? "OK";
      if (message.contains("Otp Sent to")) {
        /// success
        Navigator.push(context, OtpScreen.route(mobileNumber));
      } else {
        /// error / version update
        showMessageBar(response.message ?? "");
      }
    }, (error) {
      if (error.code == 404) {
        // Only pass mobileNumber to SignUpScreen if it's a 404 error
        Navigator.push(context, SignUpScreen.route(mobileNumber: mobileNumber));
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return welcomeBlock();
  }

  @override
  SignInScreenBloc getBloc() {
    return bloc;
  }
}
