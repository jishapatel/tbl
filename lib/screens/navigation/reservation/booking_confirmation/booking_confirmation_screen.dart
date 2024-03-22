import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../../../base/basePage.dart';
import '../../../../base/bloc/base_bloc.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../navigation_screen.dart';
import 'booking_confirmation_status_bloc.dart';

class BookingConfirmationScreen
    extends BasePage<BookingConfirmationStatusScreenBloc> {
  BookingConfirmationScreen({super.key});

  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _confirmBookingScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => BookingConfirmationScreen());
  }
}

class _confirmBookingScreenState extends BasePageState<
    BookingConfirmationScreen, BookingConfirmationStatusScreenBloc> {
  BookingConfirmationStatusScreenBloc bloc =
      BookingConfirmationStatusScreenBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return welcomeBlock();
  }

  void _onTextTapped() {
    Navigator.pushAndRemoveUntil(
      context,
      NavigationScreen.route(arguments: 2),
      (route) => false,
    );
  }

  Widget welcomeBlock() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/confirm_booking_img.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 70, left: 0, right: 0, bottom: 0),
                  child: Text(
                    'Enjoy your time!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontFamily: 'Inter-Regular',
                        color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                          top: 10, left: 0, right: 0, bottom: 0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 23.sp),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'You can check your reservation \nstatus ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'here ',
                              style: TextStyle(color: Colors.yellow),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTextTapped,
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _getContinueBtn()),
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget _getContinueBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19, top: 19, left: 24, right: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 152, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            NavigationScreen.route(arguments: 0),
            (route) => false,
          );
        },
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12, right: 88, left: 88),
          child: Text(
            "Back to Home",
            style: TextStyle(
                fontSize: 20.sp, color: Colors.white, fontFamily: 'Inter'),
          ),
        ),
      ),
    );
  }

  @override
  BookingConfirmationStatusScreenBloc getBloc() {
    return bloc;
  }
}

class CustomTextField extends TextFormField {
  CustomTextField({
    Key? key,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    bool? obscureText,
    FormFieldValidator<String>? validator,
  }) : super(
          key: key,
          decoration: decoration!.copyWith(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            suffixIcon: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          keyboardType: keyboardType,
          obscureText: true,
          validator: validator,
        );
}
