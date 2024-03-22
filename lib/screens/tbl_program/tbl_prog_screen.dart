import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';
import 'package:tbl/screens/tbl_program/tbl_prog_screen_bloc.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';

class TblProgramScreen extends BasePage<TBLProgramScreenBloc> {
  TblProgramScreen({Key? key});

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => TblProgramScreen());
  }

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
  return _TblProgramScreenState();
  }
}

class _TblProgramScreenState extends BasePageState<TblProgramScreen, TBLProgramScreenBloc> {
  TBLProgramScreenBloc bloc = TBLProgramScreenBloc();

  Widget welcomeBlock() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      // Set the status bar color to black
      statusBarBrightness: Brightness.dark,
      // Set the status bar brightness to dark
      statusBarIconBrightness:
          Brightness.light, // Set the status bar icon brightness to light
    ));
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation:0.0,
        //backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back_left_blue.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Stack(
                      alignment: Alignment.topCenter,
                      textDirection: TextDirection.rtl,
                      fit: StackFit.loose,
                      clipBehavior: Clip.hardEdge,
                      children: <Widget>[
                    // Image.asset(
                    //   'assets/images/tbl_program.png',
                    //   width: MediaQuery
                    //       .of(context)
                    //       .size
                    //       .width,
                    //   height: SizeConfig.screenHeight * 0.7,
                    //   fit: BoxFit.fill,
                    // ),
                    //     ImageView(
                    //       image: AppImages.icLoyaltyProgram,
                    //       imageType: ImageType.svg,
                    //       height: MediaQuery.of(context).size.height*0.4,
                    //       width: MediaQuery.of(context).size.width*0.4,
                    //       //boxFit: BoxFit.contain,
                    // ),
                    ImageView(
                      image: AppImages.icLoyalty,
                      imageType: ImageType.asset,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      //boxFit: BoxFit.contain,
                    ),
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 10, bottom: 7),
                        child: Padding(
                          padding:
                          EdgeInsets.only(top: 15, left: 14, right: 0, bottom: 10),
                          child: Column(
                            children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'TBL Loyalty Program',
                              style: TextStyle(
                                  fontSize: 31.sp,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: BLUE),
                              overflow: TextOverflow.ellipsis,
                              // Set the overflow property to ellipsis
                              maxLines: 2, // Set the maxLines property to 1
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 0, right: 0, bottom: 0),
                              child: Text(
                                'Program Details',
                                style: TextStyle(
                                    color: BLUE,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "The program is known as The Bier Library Loyalty Program. The program is powered by TBL’s app. Cashback gets accrued in The Bier Library wallet and the currency is Rupees.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "All cashback rewards have a validity of 90 days post which it will expire automatically.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: 15, left: 0, right: 0, bottom: 0),
                          //   child: Text(
                          //     "eWards system is integrated with our POS System. So, the billing history, order items, frequency, recency of visits etc are automatically tagged in the system.",
                          //     style: TextStyle(
                          //       color: BLUE1,
                          //       fontSize: 19.sp,
                          //     ),
                          //   ),
                          // ),
//Program enrollment
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 0, right: 0, bottom: 0),
                              child: Text(
                                'Program Enrollment',
                                style: TextStyle(
                                    color: BLUE,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "New members can be enrolled automatically when they sign-up in our app",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "A sign-up bonus of 500 points will be added to the wallet for every new user.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "On every billing, guests get 25% of the bill amount added to their wallet as reward points. The rewards point will be calculated on bill amount minus discount and excluding SC and GST) in their TBL Wallet. Validity of such points is 90 days.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 0, right: 0, bottom: 0),
                              child: Text(
                                'Wallet Amount Accrual',
                                style: TextStyle(
                                    color: BLUE,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "25% reward will automatically be credited in the wallet for members respectively after billing. All points have a validity of 90 days only.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 0, right: 0, bottom: 0),
                              child: Text(
                                "Point will be accrued 24 hours post the billing.",
                                style: TextStyle(
                                  color: BLUE1,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 0, right: 0, bottom: 0),
                              child: Text(
                                'Wallet Amount Redemption',
                                style: TextStyle(
                                    color: BLUE,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "Redemption is capped to 25% of bill value or credit point whichever is lower.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "Redemption is automatically picked up by POS system from the app at the time of billing as per the redemption rule set above.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "Redemption report is available in mobile dashboard. Redemption can be done after 24 hours",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 0, right: 0, bottom: 0),
                              child: Text(
                                'Wallet Amount Expiry',
                                style: TextStyle(
                                    color: BLUE,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "Points expire 90 days from the date of accrual. This is automatically handled in the backend system.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 0, right: 0, bottom: 0),
                            child: Text(
                              "15 days before expiry, guests get a reminder message. This has been configured in the backend.",
                              style: TextStyle(
                                color: BLUE1,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                        ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

      );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return welcomeBlock();
  }

  @override
  TBLProgramScreenBloc getBloc() {
    return bloc;
  }
}
