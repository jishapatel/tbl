import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../../base/basePage.dart';
import '../../../base/bloc/base_bloc.dart';
import '../../../base/constants/app_colors.dart';
import '../../../base/constants/app_images.dart';
import '../../../base/remote/model/home_response.dart';
import '../../../base/utils/shared_pref_utils.dart';
import '../../../base/widgets/image_view.dart';
import '../../about/about_screen.dart';
import '../../menu_list/FullscreenImageGallery.dart';
import '../../tbl_program/tbl_prog_screen.dart';
import 'home_screen_bloc.dart';

class HomeScreen extends BasePage<HomeScreenBloc> {
  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _PageOneScreenState();
  }
}

class _PageOneScreenState extends BasePageState<HomeScreen, HomeScreenBloc> {
  @override
  bool get wantKeepAlive => true;

  HomeScreenBloc bloc = HomeScreenBloc();
  int _currentIndex = 0;

  @override
  Widget? getAppBar() {
    double height = 0;
    if (MediaQuery.of(context).size.width > 600) {
      height = 50.w;
    }
    if (MediaQuery.of(context).size.width < 600) {
      height = 50.w;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return AppBar(
      toolbarHeight: height,
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      centerTitle: false,
      //elevation: 3,
      //shadowColor : DIVIDER_GREY,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: /*if(getBloc().getUserData.value?.profile?.profileImage != null)*/
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: getProfilePic().isNotEmpty
                      ? NetworkImage(getProfilePic().toString())
                      : const AssetImage(AppImages.icDefaultProfile)
                          as ImageProvider,
                  // Explicitly cast AssetImage to ImageProvider
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text('Hi ',
                style: TextStyle(
                    color: BLUE,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 21.sp)),
          ),
          Expanded(
            child: Text(
              (getFName().contains(' '))
                  ? getFName().substring(0, getFName().indexOf(' ')) + "!"
                  : "",
              //getFName().substring(0, getFName().indexOf(' ')) + "!" ?? "",
              style: TextStyle(
                  color: BLUE,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 21.sp),
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, AboutScreen.route());
          },
          child: Center(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      //decoration: TextDecoration.underline,
                        color: MARUN,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 19.sp),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 24),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18.0,
                    color: MARUN,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onReady() {
    bloc.doHome(null, (response) {});
  }

  Widget buildWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.doHome(null, (response) {});
      },
      child: buildHomePage(context),
    );
  }

  Widget buildHomePage(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: StreamBuilder<HomeResponse>(
            stream: bloc.home,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final homeResponse = snapshot.data!;
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Today’s latest offer
                      SizedBox(height: 21.5.h),
                      // Text(
                      //   'Today\'s Latest Offers',
                      //   style: TextStyle(
                      //       color: BLUE,
                      //       fontStyle: FontStyle.normal,
                      //       fontFamily: "Inter",
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 21.sp),
                      // ),
                      // SizedBox(height: 16.h),
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 226.h,
                            enableInfiniteScroll: false,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items:
                              homeResponse.todaysLatestOffers.map((offerUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                final screenWidth =
                                    MediaQuery.of(context).size.width;

                                //File file =  CachedImageWidget(imageUrl: offerUrl) as File;
                                //if(file!=null){
                                return // Inside your builder method
                                    CachedNetworkImage(
                                  imageUrl: offerUrl,
                                  width: screenWidth,
                                  height: 226.h,
                                  fit: BoxFit.fill,
                                  useOldImageOnUrlChange: false,
                                );
                                // }else{
                                //   return // Inside your builder method
                                //     CachedNetworkImage(
                                //       imageUrl: offerUrl,
                                //       width: screenWidth,
                                //       height: 226.h,
                                //       fit: BoxFit.fill,
                                //       useOldImageOnUrlChange: false,
                                //     );
                                // }

                                // return ImageView(
                                //   imageType: ImageType.network,
                                //   image: offerUrl,
                                //   width: screenWidth,
                                //   boxFit: BoxFit.fill,
                                //   height: 226.h,
                                // );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                        child: DotsIndicator(
                          dotsCount: homeResponse.todaysLatestOffers.length,
                          position: _currentIndex.toDouble(),
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeSize: const Size(12, 12),
                            // Adjust the size of the active dot
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            activeColor: BLUE,
                            // Customize the active dot color
                            spacing: const EdgeInsets.all(3.0),
                            color: PROFILE_LIGHT_GREY_DIVIDER,
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),

                      loyaltyProgramme(),

                      //Today’s offers
                      SizedBox(height: 21.5.h),
                      Text(
                        'Today\'s Offers',
                        style: TextStyle(
                            color: BLUE,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 21.sp),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                          height: 136.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: homeResponse.todaysOffer.length,
                            itemBuilder: (context, index) {
                              final offerUrl = homeResponse.todaysOffer[index];
                              final isLastItem =
                                  index == homeResponse.todaysOffer.length - 1;
                              final borderRadius = BorderRadius.circular(8.r);
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: isLastItem ? 0 : 8),
                                child: ClipRRect(
                                  borderRadius: borderRadius,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullscreenImageGallery(
                                              imageUrls:
                                                  homeResponse.todaysOffer,
                                              itemIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: offerUrl,
                                        width: 231.w,
                                        height: 130.h,
                                        fit: BoxFit.fill,
                                        useOldImageOnUrlChange: false,
                                      )
                                      // child: ImageView(
                                      //   imageType: ImageType.network,
                                      //   image: offerUrl,
                                      //   width: 231.w,
                                      //   height: 130.h,
                                      // ),
                                      ),
                                  // child: ImageView(
                                  //   imageType: ImageType.network,
                                  //   image: offerUrl,
                                  //   width: 231.w,
                                  //   height: 130.h,
                                  // ),
                                ),
                              );
                            },
                          )),

                      //Our Menu
                      SizedBox(height: 21.5.h),
                      Text(
                        'Our Menu',
                        style: TextStyle(
                            color: BLUE,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 21.sp),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        height: 200.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: homeResponse.ourMenu.length,
                          itemBuilder: (context, index) {
                            final offerUrl = homeResponse.ourMenu[index];
                            final isLastItem =
                                index == homeResponse.ourMenu.length - 1;
                            return Padding(
                              padding:
                                  EdgeInsets.only(right: isLastItem ? 0 : 8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullscreenImageGallery(
                                        imageUrls: homeResponse.ourMenu,
                                        itemIndex: index,
                                      ),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: offerUrl,
                                  width: 128.w,
                                  height: 200.h,
                                  fit: BoxFit.fill,
                                  useOldImageOnUrlChange: false,
                                ),
                                // child: ImageView(
                                //   imageType: ImageType.network,
                                //   image: offerUrl,
                                //   width: 128.w,
                                //   height: 200.h,
                                // ),
                              ),
                            );
                          },
                        ),
                      ),

                      //Upcoming Events
                      SizedBox(height: 21.5.h),
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                            color: BLUE,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 21.sp),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        height: 130.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: homeResponse.upcomingEvents.length,
                          itemBuilder: (context, index) {
                            final offerUrl = homeResponse.upcomingEvents[index];
                            final isLastItem =
                                index == homeResponse.upcomingEvents.length - 1;
                            return Padding(
                                padding:
                                    EdgeInsets.only(right: isLastItem ? 0 : 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullscreenImageGallery(
                                          imageUrls:
                                              homeResponse.upcomingEvents,
                                          itemIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: offerUrl,
                                    width: 231.w,
                                    height: 130.h,
                                    fit: BoxFit.fill,
                                    useOldImageOnUrlChange: false,
                                  ),
                                  /*child: ImageView(
                                    imageType: ImageType.network,
                                    image: offerUrl,
                                    width: 231.w,
                                    height: 130.h,
                                  ),*/
                                ));
                          },
                        ),
                      ),

                      //Past Events
                      SizedBox(height: 21.5.h),
                      Text(
                        'Best-sellers',
                        style: TextStyle(
                            color: BLUE,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 21.sp),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        height: 130.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: homeResponse.pastEvents.length,
                          itemBuilder: (context, index) {
                            final offerUrl = homeResponse.pastEvents[index];
                            final isLastItem =
                                index == homeResponse.pastEvents.length - 1;
                            return Padding(
                                padding:
                                    EdgeInsets.only(right: isLastItem ? 0 : 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullscreenImageGallery(
                                          imageUrls: homeResponse.pastEvents,
                                          itemIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: offerUrl,
                                    width: 231.w,
                                    height: 130.h,
                                    fit: BoxFit.fill,
                                    useOldImageOnUrlChange: false,
                                  ),
                                  // child: ImageView(
                                  //   imageType: ImageType.network,
                                  //   image: offerUrl,
                                  //   width: 231.w,
                                  //   height: 130.h,
                                  // ),
                                ));
                          },
                        ),
                      ),
                      SizedBox(height: 29.h),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error occurred'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  HomeScreenBloc getBloc() {
    return bloc;
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  profilePicWidget() {
    return Container(
      padding: EdgeInsets.only(left: 18),
      child: ImageView(
        image: getProfilePic() ?? "",
        imageType: ImageType.network,
        width: 48.w,
        height: 48.h,
        imageShape: ImageShape.circle,
        boxFit: BoxFit.cover,
      ),
    );
  }

  loyaltyProgramme() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, TblProgramScreen.route());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: LIGHT_BLUE,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding:
                EdgeInsets.only(left: 34, top: 15, bottom: 15, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TBL Loyalty Program",
                      style: TextStyle(
                        color: BLUE,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 21.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "The program is known as The Bier Library Loyalty Program. The program is powered by TBL’s app.",
                      style: TextStyle(
                        color: BLUE,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(right: 36),
              icon: ImageView(
                image: AppImages.icLoyaltyProgramme,
                imageType: ImageType.svg,
              ),
              onPressed: () {
                Navigator.push(context, TblProgramScreen.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}
