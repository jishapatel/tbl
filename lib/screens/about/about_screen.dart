import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_images.dart';
import '../../base/widgets/SizeConfig.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';
import 'about_screen_bloc.dart';

class AboutScreen extends BasePage<AboutScreenBloc> {
  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _AboutScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => AboutScreen());
  }

}

class _AboutScreenState extends BasePageState<AboutScreen,AboutScreenBloc> {
  bool value = false;
  AboutScreenBloc bloc = AboutScreenBloc();

  @override
  Color scaffoldColor() {
    return Colors.white;
  }

  // @override
  // Widget? getAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.transparent,
  //     leading: IconButton(
  //       icon: SvgPicture.asset('assets/icons/back_left_blue.svg'),
  //       onPressed: () {
  //         Navigator.pop(context);
  //       },
  //     ),
  //   );
  // }
  //

  Widget welcomeBlock() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                    alignment: Alignment.topCenter,
                    textDirection: TextDirection.rtl,
                    fit: StackFit.loose,
                    //overflow: Overflow.visible,
                    clipBehavior: Clip.hardEdge,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/welcome.jpg',
                        width: MediaQuery.of(context).size.width,
                        height: SizeConfig.screenHeight,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 55, bottom: 10),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 200.w,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 80, left: 24, right: 24),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: ImageView(
                                image: AppImages.icBackWhite,
                                imageType: ImageType.svg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 24.0, right: 24.0, top: 23, bottom: 0),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            color: Color(0xffac145a),
                            fontSize: 21.sp,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "The Bier Library",
                          style: TextStyle(
                            color: Color(0xff002f6c),
                            fontSize: 27.sp,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: middlePart(),
            ),
          ),
        ],
      ),
    );
  }

  Widget middlePart() {
    return Column(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              margin: const EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 23, bottom: 0),
              alignment: Alignment.topLeft,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "A hidden gem nestled in the heart of Koramangala, The Bier Library is paradise for all food and beer lovers in the city. Spread over two spacious floors, our 20,000 sq. ft microbrewery promises riveting views from every corner.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 28, 63),
                          fontSize: 18.sp,
                          height: 1.5,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        " From pâté to pasta and everything in between, our menu has been curated by a team of gastronomical geniuses. And no matter what your palate craves, we've got it for you.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 28, 63),
                          fontSize: 18.sp,
                          height: 1.5,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "For those more inclined towards quenching their thirst, our magic potions are just for you. We’ve got a medley of mixes, a fusion of flavours guaranteed to lift spirits. And as our seven fresh, frothy brews, make their way straight from our brewery to your heart, we guarantee nothing but happiness to you.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 28, 63),
                          fontSize: 18.sp,
                          height: 1.5,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "We keep things fresh and exciting by introducing a new beer on tap every month on rotation. We also work in tandem with other brewers and breweries to craft a range of unique, mouth-watering beers for our loyal beer drinkers.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 28, 63),
                          fontSize: 18.sp,
                          height: 1.5,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Whatever the occasion, whether it's a Sunday barbeque with the family, a mid-week break with your co-workers, an evening alone or the perfect date, The Bier Library is the place to be.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 28, 63),
                          fontSize: 18.sp,
                          height: 1.5,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ]))
        ]),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return welcomeBlock();
  }

  @override
  getBloc() {
    return bloc;
  }
}
