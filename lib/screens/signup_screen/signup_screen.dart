import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';
import 'package:tbl/screens/signup_screen/sign_up_screen_bloc.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/SizeConfig.dart';
import '../../base/widgets/custom_page_route.dart';
import '../otp/otp_screen.dart';
import '../sign_in/signin_screen.dart';

class SignUpScreen extends BasePage<SignUpScreenBloc> {
  final String? mobileNumber; // Accept mobile number as parameter

  SignUpScreen({Key? key, this.mobileNumber}) : super(key: key);

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _SignUpScreenState(mobileNumber: mobileNumber);
  }

  static Route<dynamic> route({String? mobileNumber}) {
    // Update route method
    return CustomPageRoute(
        builder: (context) => SignUpScreen(
            mobileNumber: mobileNumber)); // Pass mobileNumber to SignUpScreen
  }
}

class _SignUpScreenState extends BasePageState<SignUpScreen, SignUpScreenBloc> {
  SignUpScreenBloc bloc = SignUpScreenBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final String? mobileNumber; // Accept mobile number as parameter

  final FocusNode _nodeNameNumber = FocusNode();
  final FocusNode _nodeMobileNumber = FocusNode();
  final FocusNode _nodeDobNumber = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  DateTime? selectedDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValidName = false;
  bool _isValidPhoneNumber = false;
  bool _isValidDobNumber = false;
  bool _isEmpty = false;
  bool _isValid = false;
  String number = "";

  _SignUpScreenState({this.mobileNumber}); // Constructor

  @override
  void initState() {
    super.initState();
    _mobileNumberController.text =
        (widget.mobileNumber ?? '').replaceAll('+91', '');
    _validatePhone(); // Automatically validate the mobile number
    _mobileNumberController.addListener(_validatePhone);
    _nameController.addListener(_validatePhone); // Add listener for name field
    _dobController.addListener(_validatePhone);
    _isEmpty = true;
    _isValid = false;
  }

  void _validatePhone() {
    final String phone = _mobileNumberController.text.trim();
    final bool isValid = RegExp(r'^[0-9]{10}$').hasMatch(phone);
    final bool isValidName = _nameController.text.isNotEmpty; // Check name validity

    setState(() {
      _isEmpty = phone.isEmpty;
      _isValidPhoneNumber = isValid;
      _isValidName = isValidName;
      _isValid = _isValidName && _isValidPhoneNumber && _isValidDobNumber;

      if (_mobileNumberController.text.isEmpty &&
              _mobileNumberController.text.length != 10
          ? true
          : false) {
        _isValid = false;
      } else {
        _isValid = true;
      }
      if (_nameController.text.isEmpty ? true : false) {
        _isValid = false;
      }
      if (_dobController.text.isEmpty ? true : false) {
        _isValid = false;
      }
      print(_isDateOfBirthValid());
      print(_isValid);

      //_isValid = _dobController.text.isNotEmpty ? true: false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      // builder: (BuildContext context, Widget? child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       colorScheme: ColorScheme.light(
      //         primary: Colors.white, // Change the background color here
      //       ),
      //     ),
      //     child: child!,
      //   );
      //},
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        String date = selectedDate?.day != null &&
                selectedDate?.month != null &&
                selectedDate?.year != null
            ? '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}'
            : '';
        _isValidDobNumber = date.isNotEmpty ? true : false;
        if (date.isNotEmpty &&
            _isValidPhoneNumber == true &&
            _nameController.text.isNotEmpty) {
          _isValid = true;
        }
      });
    }
  }

  Widget welcomeBlock() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        _topImage(),
        SizedBox(height: 25.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 31.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 47, 108)),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, SigninScreen.route());
                      },
                      child: Row(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xff011c3f),
                              fontSize: 23.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          //Icon(Icons.arrow_right_alt_rounded),
                          SizedBox(
                            width: 4.w,
                          ),
                          SvgPicture.asset(
                            'assets/icons/back_right.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                'Let’s reserve table and earn exclusive points with TBL Loyalty Programme.',
                style: TextStyle(
                    fontSize: 17.sp,
                    height: 1.5,
                    fontFamily: 'Inter',
                    color: Color.fromARGB(255, 1, 28, 63)),
              ),
              SizedBox(height: 25.h),
              _userName(),
              SizedBox(height: 10.h),
              _mobileNumber(),
              SizedBox(height: 10.h),
              _dateOfBirth(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: _getFAB(),
          ),
        ),
      ],
    )));
  }

  Widget _topImage() {
    return Image.asset(
      'assets/images/rect.png',
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.screenHeight * 0.9,
      fit: BoxFit.fill,
    );
  }

  Widget _userName() {
    return TextField(
      onChanged: (value) {
        setState(() {}); // Trigger rebuild
      },
      controller: _nameController,
      focusNode: _nodeNameNumber,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 19.sp,
        color: Color.fromARGB(255, 42, 44, 49),
      ),
      decoration: InputDecoration(
        counterText: '',
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
          borderRadius: BorderRadius.circular(28.0.r),
        ),
        errorText: _isEmpty ? null : (_isValidName ? null : "Please enter a name"),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0.r),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 192, 192, 192),
            width: 1.0.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
          borderRadius: BorderRadius.circular(28.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
          borderRadius: BorderRadius.circular(28.0.r),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 19.sp,
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        hintText: "Name",
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(27, 16, 0, 16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: const Icon(
              Icons.person_rounded,
              color: Color.fromARGB(255, 192, 192, 192),
            ),
          ),
        ),
        suffixIcon: _nameController.text.isNotEmpty // Show suffix icon based on name field
            ? _isValidName
            ? Icon(
          Icons.check,
          color: Colors.green,
        )
            : Icon(
          Icons.close_rounded,
          color: Colors.red,
        )
            : null,
      ),
    );
  }

  Widget _mobileNumber() {
    bool isValidMobileNumber = RegExp(r'^[0-9]{10}$').hasMatch(_mobileNumberController.text.trim());
    IconData? suffixIcon;

    if (_mobileNumberController.text.isNotEmpty) {
      suffixIcon = isValidMobileNumber ? Icons.check : Icons.close_rounded;
    }

    return TextField(
      controller: _mobileNumberController,
      focusNode: _nodeMobileNumber,
      maxLength: 10,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 19.sp,
        color: Color.fromARGB(255, 42, 44, 49),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        counterText: '',
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
          borderRadius: BorderRadius.circular(28.0.r),
        ),
        errorText: _isEmpty ? null : (isValidMobileNumber ? null : "Please enter a valid mobile number"),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0.r),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 192, 192, 192),
            width: 1.0.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
          borderRadius: BorderRadius.circular(28.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
          borderRadius: BorderRadius.circular(28.0.r),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 19.sp,
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        hintText: "Mobile number",
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
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: isValidMobileNumber ? Colors.green : Colors.red) : null,
      ),
    );
  }

  Widget _dateOfBirth() {
    String? errorText = (selectedDate != null)
        ? !_isDateOfBirthValid()
            ? 'Invalid date of birth'
            : null
        : null;

    _dobController.text = selectedDate?.day != null &&
            selectedDate?.month != null &&
            selectedDate?.year != null
        ? '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}'
        : '';

    return TextField(
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 19.sp,
        color: Color.fromARGB(255, 42, 44, 49),
      ),
      showCursor: false,
      onTap: () {
        showCursor:
        false;
        _nodeDobNumber.unfocus();
        _selectDate(context);
        FocusScope.of(context).unfocus();
      },
      //enabled: false,
      controller: _dobController,
      // controller: TextEditingController(
      //     text: selectedDate?.day != null &&
      //             selectedDate?.month != null &&
      //             selectedDate?.year != null
      //         ? '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}'
      //         : ''),
      focusNode: _nodeDobNumber,
      decoration: InputDecoration(
        counterText: '',
        errorBorder: outLineBorder(),
        errorText: errorText,
        //_isEmpty ? null : (_isValidDobNumber ? null : "Sign up with us when you turn 21!"),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        border: outLineBorder(),

        focusedErrorBorder: outLineBorder(),
        focusedBorder: outLineBorder(),
        //hintStyle: const TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 19.sp,
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        hintText: "Date of birth",
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(27, 16, 0, 16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: SvgPicture.asset(
              'assets/icons/calendar.svg',
            ),
            /*child: const Icon(//calendar.svg
              Icons.calendar_month,
              color: Color.fromARGB(255, 192, 192, 192),
            ),*/
          ),
        ),
        // suffixIcon: _isEmpty
        //     ? null
        //     : _isValidDobNumber
        //         ? const Icon(
        //             Icons.check,
        //             color: Colors.green,
        //           )
        //         : const Icon(
        //             Icons.close_rounded,
        //             color: Colors.red,
        //           ),
      ),
    );
  }

  bool _isDateOfBirthValid() {
    if (selectedDate == null) {
      return false;
    }

    final now = DateTime.now();
    final eighteenYearsAgo = now.subtract(const Duration(days: 365 * 18));

    return selectedDate!.isBefore(eighteenYearsAgo);
  }

  outLineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
      borderRadius: BorderRadius.circular(28.0.r),
    );
  }

  Widget _getFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 43, top: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: (_isValidName &&
                  _isValid &&
                  _isValidPhoneNumber &&
                  _isDateOfBirthValid())
              ? Color.fromARGB(255, 255, 152, 0)
              : Color.fromARGB(255, 234, 234, 234),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
          elevation: 0,
        ),
        onPressed: (_isValid &&
                _isDateOfBirthValid() &&
                _mobileNumberController.text.isNotEmpty)
            ? () => onContinue()
            : null,
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            "Request OTP",
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w500,
              color: _isValid ? Colors.white : Color.fromARGB(89, 2, 51, 126),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }

  void onContinue() {
    hideKeyboard(context);
    String mobileNumber = "+91" + _mobileNumberController.text.trim();

    final Map<String, dynamic> requestData = {
      'user': {
        'phone_number': mobileNumber,
        'profile_attributes': {
          'name': _nameController.text.toString(),
          'date_of_birth':
              '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}'
        }
      }
    };

    getBloc().doSignUp(requestData, (response) {
      String message = response.message ?? "OK";
      if (message.contains("Otp Sent to")) {
        /// success
        Navigator.push(context, OtpScreen.route(mobileNumber));
      } else {
        /// error / version update
        showMessageBar(response.message ?? "");
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return welcomeBlock();
  }

  @override
  SignUpScreenBloc getBloc() {
    return bloc;
  }
}
