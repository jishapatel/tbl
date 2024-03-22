import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';
import 'package:tbl/screens/navigation/profile/profile_bloc.dart';

import '../../../base/basePage.dart';
import '../../../base/bloc/base_bloc.dart';
import '../../../base/constants/app_colors.dart';
import '../../../base/constants/app_constant.dart';
import '../../../base/constants/app_images.dart';
import '../../../base/constants/app_widgets.dart';
import '../../../base/remote/model/profile_response.dart';
import '../../../base/utils/date_util.dart';
import '../../../base/utils/shared_pref_utils.dart';
import '../../../base/widgets/appbar_view.dart';
import '../../../base/widgets/custom_page_route.dart';
import '../../../base/widgets/image_view.dart';
import '../../../widgets/dialogscreen.dart';

class ProfileScreen extends BasePage<ProfileScreenBloc> {
  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _ProfileScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => ProfileScreen());
  }
}

class _ProfileScreenState
    extends BasePageState<ProfileScreen, ProfileScreenBloc> {
  ProfileScreenBloc bloc = ProfileScreenBloc();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final _textFieldController = TextEditingController();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  DateTime? selectedDate;

  bool _isValidPhoneNumber = false;
  bool _isEmpty = false;
  bool _isValid = false;
  String number = "";

  // @override
  // void onReady() {
  //   //getUser();
  //   super.onReady();
  // }

  @override
  void initState() {
    super.initState();
    _mobileNumberController.addListener(_validatePhone);
    _isEmpty = true;
    _isValid = false;
    getUser();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return welcomeBlock();
  }

  @override
  ProfileScreenBloc getBloc() {
    return bloc;
  }

  @override
  Widget? getAppBar() {
    return AppBarView(
      color: Colors.white,
      centerTitle: true,
      title: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "My Profile",
                style: TextStyle(
                    color: BLUE,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 23.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeBlock() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    return SafeArea(
        child: SafeArea(
            child: CustomScrollView(reverse: false, slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Material(
            child: StreamBuilder<UserDetails?>(
                stream: getBloc().getUserDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return _mainBloc();
                  } else {
                    return const SizedBox();
                  }
                })),
      ),
    ])));
  }

  Widget _mainBloc() {
    return Column(
      children: [
        //SizedBox(height: 16),
        //_header(),
        SizedBox(height: 11.h),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 136.w,
              height: 136.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: getBloc().getUserData.value?.profile?.profileImage !=
                //           null
                //       ? NetworkImage(getBloc()
                //           .getUserData
                //           .value!
                //           .profile!
                //           .profileImage
                //           .toString())
                //       : NetworkImage(
                //           "https://gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.jpg"),
                //   fit: BoxFit.cover,
                // ),
                image: DecorationImage(
                  image: getBloc().getUserData.value?.profile?.profileImage !=
                          null
                      ? NetworkImage(getBloc()
                          .getUserData
                          .value!
                          .profile!
                          .profileImage
                          .toString())
                      //: AssetImage('assets/default_image.png') as ImageProvider, // Explicitly cast AssetImage to ImageProvider
                      : AssetImage(AppImages.icDefaultProfile) as ImageProvider,
                  // Explicitly cast AssetImage to ImageProvider
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 0,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ), //camera.svg
                child: GestureDetector(
                  onTap: () {
                    captureGalleryPhoto();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 192, 192, 192),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          getBloc().getUserData.value?.profile?.name?.toString() ?? "",
          style: TextStyle(
            color: Color(0xff002f6c),
            fontSize: 21.sp,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
          ),
        ),
        //settings
        SizedBox(height: 20.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Account",
                  style: TextStyle(
                    color: Color(0xff002f6c),
                    fontSize: 21.sp,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              _mobileNumber(),
              _divider(),
              _emailField(),
              _divider(),
              _dateOfBirth(),
              _divider(),
              SizedBox(height: 16.h),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Color(0xff002f6c),
                    fontSize: 21.sp,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              GestureDetector(
                  onTap: () {
                    onLogout();
                  },
                  child: _staticField(AppImages.icLogout, "  Logout")),
              _divider(),
              SizedBox(height: 2.h),
              GestureDetector(
                  onTap: () {
                    _eventDeActivateAccount();
                  },
                  child: _staticField(
                      AppImages.icDeActivate, " Deactivate account")),
              _divider(),
              SizedBox(height: 2.h),
              GestureDetector(
                  onTap: () {
                    _eventDeleteAccount();
                  },
                  child: _staticField(AppImages.icDelete, "   Delete account")),
              _divider(),
              SizedBox(height: 16.h),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Support",
                  style: TextStyle(
                    color: Color(0xff002f6c),
                    fontSize: 21.sp,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              _staticField(AppImages.icCall, " 9108180000"),
              _divider(),
              SizedBox(height: 2.h),
              _staticField(AppImages.icEmail, "  connect@frothytales.com"),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Version 1.0.2',
                  style: TextStyle(
                    color: GREY,
                    fontSize: 16.sp,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Profile',
            style: TextStyle(
              color: Color(0xff011c3f),
              fontSize: 23.sp,
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // other widgets
      ],
    );
  }

  outLineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 192, 192, 192)),
      borderRadius: BorderRadius.circular(28.0),
    );
  }

  Widget _mobileNumber() {
    return Row(
      children: [
        SizedBox(
          width: 4.w,
        ),
        Icon(
          Icons.phone,
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        SizedBox(width: 10.w),
        Text(
          getBloc().getUserData.value?.phoneNumber.toString() ?? "",
          style: TextStyle(fontSize: 19.sp),
        ),
      ],
    );
  }

  Widget _emailField() {
    return Row(
      children: [
        SizedBox(
          width: 4.w,
        ),
        SvgPicture.asset(
          'assets/icons/at.svg',
          width: 20,
          height: 20,
        ),
        SizedBox(width: 18.w),
        Text(
          getBloc().getUserData.value?.profile?.email ?? "",
          style: TextStyle(fontSize: 19.sp),
        ),
        Flexible(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return MyUpdatePage(
                      onEvent: _eventHandle,
                    );
                  },
                );
              },
              child: SvgPicture.asset(
                'assets/icons/edit.svg',
                width: 22,
                height: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateOfBirth() {
    DateTime? now = getBloc().getUserData.value?.profile?.dateOfBirth;
    String dob = DateFormat('dd/MM/yyyy').format(now!);
    return Row(
      children: [
        SizedBox(
          width: 4.w,
        ),
        SvgPicture.asset(
          'assets/icons/calendar.svg',
          width: 18,
          height: 20,
        ),
        SizedBox(width: 20.w),
        Text(
          dob ?? "",
          style: TextStyle(fontSize: 19.sp),
        ),
      ],
    );
  }

  Widget _staticField(String path, String fieldName) {
    return Row(
      children: [
        SizedBox(
          width: 4.w,
        ),
        ImageView(
          image: path,
          imageType: ImageType.svg,
        ),
        // Icon(
        //   Icons.phone,
        //   color: Color.fromARGB(255, 192, 192, 192),
        // ),
        SizedBox(width: 10.w),
        Text(
          fieldName,
          style: TextStyle(fontSize: 19.sp),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(
      color: PROFILE_LIGHT_GREY_DIVIDER,
      thickness: 1,
    );
  }

  void onContinue() {
    hideKeyboard(context);
    String mobileNumber = "+91" + _mobileNumberController.text.trim();
    Map? requestData = {USER_MOBILE: mobileNumber};

    // getBloc().doSignUp(requestData, (response) {
    //   String message = response.message ?? "OK";
    //   if (message.contains("Otp Sent to")) {
    //     /// success
    //     Navigator.push(context, OtpScreen.route(mobileNumber));
    //     //showMessageBar(response.message ?? "");
    //   } else {
    //     /// error / version update
    //     showMessageBar(response.message ?? "");
    //   }
    // });
  }

  Widget openAlert() {
    return AlertDialog(
      title: Text("Email address"),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: "your_mail@mail.com"),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            String enteredText = _textFieldController.text;
            // Do something with the entered text
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _validatePhone() {
    final String phone = _mobileNumberController.text.trim();
    final bool isValid = RegExp(r'^[0-9]{10}$').hasMatch(phone);
    setState(() {
      _isEmpty = phone.isEmpty;
      _isValidPhoneNumber = isValid;
      if (_mobileNumberController.text.isEmpty ? true : false) {
        _isValid = false;
      }
      if (_nameController.text.isEmpty ? true : false) {
        _isValid = false;
      }
      if (_dobController.text.isEmpty ? true : false) {
        _isValid = false;
      }
    });
  }

  void getUser() {
    print(getBearerToken());
    getBloc().getUserDetails(
      (response) {
        print(response.toJson());
        ProfileScreenBloc();
        setName(response.profile!.name.toString());
        getBloc().getUserData.add(response);
      },
    );
  }

  _eventHandle(String email) {
    print(email);

    if (email.isNotEmpty) {
      final Map<String, dynamic> requestData = {
        'profile': {
          'email': email,
        }
      };

      getBloc().saveUserDetails(requestData, (response) {
        getUser();
      });
    }
  }

  _eventDeActivateAccount() {
    getBloc().deActivateAccount((response) {
      onLogout();
    });
  }

  _eventDeleteAccount() {
    getBloc().deleteAccount((response) {
      onLogout();
    });
  }

  Future<void> captureGalleryPhoto() async {
    final XFile? xFile = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 500.w, maxHeight: 500.h);
    if (xFile != null) {
      print(xFile.toString());
      getBloc().doUploadProfile(xFile, (response) {
        getUser();
      });
    }
  }
}
