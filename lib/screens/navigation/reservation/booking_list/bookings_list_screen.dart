import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../../../base/basePage.dart';
import '../../../../base/bloc/base_bloc.dart';
import '../../../../base/constants/app_colors.dart';
import '../../../../base/constants/app_constant.dart';
import '../../../../base/constants/app_images.dart';
import '../../../../base/remote/model/bookings_response.dart';
import '../../../../base/utils/date_util.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../../../base/widgets/image_view.dart';
import '../../../common/alert_dialogue.dart';
import '../../../common/common_dialogue.dart';
import '../reserve_table/reserve_table_screen.dart';
import 'bookings_list_screen_bloc.dart';

class BookingsList extends BasePage<BookingListScreenBloc> {
  final Function onRefresh;

  BookingsList({required this.onRefresh});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _BookingsListState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => BookingsList(onRefresh: () => {}));
  }
}

class _BookingsListState
    extends BasePageState<BookingsList, BookingListScreenBloc>
    with WidgetsBindingObserver {
  //final Function onPopCallback;
  final _reminderDetailsKey = GlobalKey<FormState>();

  BookingListScreenBloc bloc = BookingListScreenBloc();
  int selectedBookingId = 0;

  @override
  Future<bool> onWillPopScope() {
    print("onPopUp");
    return super.onWillPopScope();
  }

  // @override
  // Widget? getAppBar() {
  //   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   //   statusBarColor: Colors.white,
  //   //   statusBarBrightness: Brightness.dark,
  //   //   statusBarIconBrightness: Brightness.dark,
  //   // ));
  //   return AppBarView(
  //     color: Colors.white,
  //     centerTitle: false,
  //     title: Row(
  //       children: [
  //         Expanded(
  //           child: Center(
  //             child: Text(
  //               "",
  //               style: TextStyle(
  //                   color: BLUE,
  //                   fontStyle: FontStyle.normal,
  //                   fontFamily: "Inter",
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 21.sp),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Implement your code here
  @override
  void onResume() {
    super.onResume();
    print("onResume" + DateTime.now().toString());
    bloc.getBookingDetails(
        null,
        (response) => () {
              print("onResume" + " got data response");
            });
  }

  @override
  void setState(VoidCallback fn) {
    bloc.getBookingDetails(
        null,
        (response) => () {
              print("onResume" + " got data in setState");
            });
    super.setState(fn);
  }

  @override
  Widget buildWidget(BuildContext context) {
    print("refresh");
    DateTime today = DateTime.now();
    if (_notification != null) {
      switch (_notification) {
        case AppLifecycleState.resumed:
          // Handle the resumed state
          print("resume");
          break;
        case AppLifecycleState.inactive:
        // Handle the inactive state
          print("inactive");
          break;
        case AppLifecycleState.paused:
        // Handle the paused state
          print("pause");
          break;
        case AppLifecycleState.detached:
          // Handle the detached state
          print("detached");
          break;
        default:
          // Handle any other unexpected or unhandled states
          break;
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: 36.h,
              ),
              GestureDetector(
                  child: loyaltyProgramme(),
                  onTap: () {
                    Navigator.push(context, ReserveTableScreen.route());
                  }),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: StreamBuilder<BookingsResponse>(
                    stream: getBloc().homeResponseStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<BookingsResponse> snapshot) {
                      if (snapshot.hasData) {
                        final reservationResponse = snapshot.data!;
                        reservationResponse.bookings?.sort(
                            (a, b) => b.bookingDate!.compareTo(a.bookingDate!));
                        final upcomingBookings = reservationResponse.bookings
                            ?.where((booking) =>
                                booking.bookingDate!.isAfter(today));
                        final pastBookings = reservationResponse.bookings
                            ?.where((booking) =>
                                booking.bookingDate!.isBefore(today) ||
                                booking.bookingDate!.isAtSameMomentAs(today));
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            InkWell(
                              onTap: () {
                                // navigate to create booking
                              },
                              child: Text(
                                'My Reservations',
                                style: TextStyle(
                                  color: BLUE,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 27.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            if (upcomingBookings!.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Text(
                                        'Upcoming',
                                        style: TextStyle(
                                          color: BLUE,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  ListView.builder(
                                    padding: EdgeInsets.only(top: 0),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: upcomingBookings.length,
                                    itemBuilder: (context, index) {
                                      final bookingItem =
                                          upcomingBookings.elementAt(index);
                                      if (bookingItem.status == "cancelled") {
                                        return _itemCancelRow(bookingItem);
                                      } else if (bookingItem.status ==
                                          "confirmed") {
                                        return _itemConfirmRow(bookingItem);
                                      } else {
                                        return _emptyUpcomingItem();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            if (upcomingBookings!.isEmpty) _emptyUpcomingItem(),
                            SizedBox(height: 16.h),
                            if (pastBookings!.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Text(
                                        'Past',
                                        style: TextStyle(
                                          color: BLUE,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  ListView.builder(
                                    padding: EdgeInsets.only(top: 0),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: pastBookings.length,
                                    itemBuilder: (context, newIndex) {
                                      final bookingItem =
                                          pastBookings.elementAt(newIndex);
                                      if (bookingItem.status == "cancelled") {
                                        return _itemCancelRow(bookingItem);
                                      } else if (bookingItem.status ==
                                          "confirmed") {
                                        return _itemPastRow(bookingItem);
                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            if (pastBookings!.isEmpty) _emptyPastItem(),
                            SizedBox(height: 29.h),
                          ],
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyUpcomingItem() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                'Upcoming',
                style: TextStyle(
                  color: BLUE,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 21.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ImageView(
            image: AppImages.icEmptyUpcoming,
            imageType: ImageType.asset,
          ),
          SizedBox(height: 34.0.h),
          Text(
            'No Upcoming reservations!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFF9800),
              fontSize: 22.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.07,
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyPastItem() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                'Past',
                style: TextStyle(
                  color: BLUE,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 21.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ImageView(
            image: AppImages.icEmptyUpcoming,
            imageType: ImageType.asset,
          ),
          SizedBox(height: 34.0.h),
          Text(
            'No bookings in the past!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFF9800),
              fontSize: 22.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.07,
            ),
          )
        ],
      ),
    );
  }

  Widget _itemConfirmRow(Booking bookingItem) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: BLUE_3B5395,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "15 May at 15:30pm",
                    getDate(bookingItem.bookingDate!) +
                        " at " +
                        (getTime(bookingItem.bookingDate!)
                            .toString()
                            .replaceAll(" ", "")
                            .toLowerCase()),
                    style: TextStyle(
                      color: YELLOW_100,
                      fontSize: 19.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    bookingItem.bookingAreaType.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "${bookingItem.noOfPeople == 1 ? "${bookingItem.noOfPeople} Guest" : "${bookingItem.noOfPeople} Guests "}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        bookingItem.status.toString(),
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: LIME_COLOR,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              //SizedBox(width: 46.w),
              if (MediaQuery.of(context).size.width > 600)
                SizedBox(width: 180.w),

              if (MediaQuery.of(context).size.width < 600)
                SizedBox(width: 46.w),

              if (bookingItem.status != "cancelled")
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          selectedBookingId = bookingItem.id!;
                          //return CustomAlertDialog(onEvent: (bool ) {  },);
                          return DialogExample(
                            onEvent: _eventHandle,
                          );
                        });
                    //cancelBooking(bookingItem.id!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: YELLOW,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemCancelRow(Booking bookingItem) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: GRAY_EAEEFF,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "15 May at 15:30pm",
                    getDate(bookingItem.bookingDate!) +
                        " at " +
                        (getTime(bookingItem.bookingDate!)
                            .toString()
                            .replaceAll(" ", "")
                            .toLowerCase()),
                    style: TextStyle(
                      color: YELLOW,
                      fontSize: 19.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    bookingItem.bookingAreaType.toString(),
                    style: TextStyle(
                      color: BLUE,
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "${bookingItem.noOfPeople == 1 ? "${bookingItem.noOfPeople} Guest" : "${bookingItem.noOfPeople} Guests "}",
                    style: TextStyle(
                      color: BLUE,
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
              if (MediaQuery.of(context).size.width > 600)
                SizedBox(width: 160.w),
              if (MediaQuery.of(context).size.width < 600)
                SizedBox(width: 30.w),
              if (bookingItem.status == "cancelled")
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // Aligns items at the start and end
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //Spacer(),
                      //SizedBox(width: 8,),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                selectedBookingId = bookingItem.id!;
                                //return CustomAlertDialog(onEvent: (bool ) {  },);
                                return DialogExample(
                                  onEvent: _eventHandle,
                                );
                              });
                          //cancelBooking(bookingItem.id!);
                        },
                        child: Text(
                          "Cancelled",
                          style: TextStyle(
                            color: LIGHT_RED,
                            fontSize: 17.sp,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemPastRow(Booking bookingItem) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: GRAY_EAEEFF,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "15 May at 15:30pm",
                    getDate(bookingItem.bookingDate!) +
                        " at " +
                        (getTime(bookingItem.bookingDate!)
                            .toString()
                            .replaceAll(" ", "")
                            .toLowerCase()),
                    style: TextStyle(
                      color: YELLOW,
                      fontSize: 19.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    bookingItem.bookingAreaType.toString(),
                    style: TextStyle(
                      color: BLUE,
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${bookingItem.noOfPeople == 1 ? "${bookingItem.noOfPeople} Guest" : "${bookingItem.noOfPeople} Guests "}",
                    style: TextStyle(
                      color: BLUE,
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
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
  BookingListScreenBloc getBloc() {
    return bloc;
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     //do your stuff
  //     print("onResumed called");
  //   }
  // }
//https://stackoverflow.com/questions/44331725/onresume-and-onpause-for-widgets-on-flutter
  AppLifecycleState _notification = AppLifecycleState.inactive;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onRefresh();
    });
    // WidgetsBinding.instance.addObserver(this);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   onReady();
    //   onResume();
    // });
    bloc.getBookingDetails(null, (response) => () {});
  }

  loyaltyProgramme() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: LIGHT_BLUE2,
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
                    "Reserve Your Table",
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
                    "Reserve your spot and elevate your dinning experience hassle free!",
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
            padding: const EdgeInsets.only(right: 36),
            icon: ImageView(
              image: AppImages.icLoyaltyProgramme,
              imageType: ImageType.svg,
            ),
            onPressed: () {
              Navigator.push(context, ReserveTableScreen.route());
              //Navigator.push(context, ReserveTableScreen.route());
            },
          ),
        ],
      ),
    );
  }

  _eventHandle(bool isCancel) {
    cancelBooking(selectedBookingId);
  }

  void cancelBooking(int id) {
    Map? requestData = {BOOKING_ID: id};
    getBloc().cancelBooking(
      requestData,
          (response) {
        showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                onEvent: (bool) {},
              );
            });
        bloc.getBookingDetails(null, (response) => () {});
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  // print("onChangeLifeCycle");
  // if (state == AppLifecycleState.paused) {
  // print("onPaused");
  // } else if (state == AppLifecycleState.resumed) {
  // print("onResume");
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

String getDate(DateTime bookingDate) {
  String date = DateFormat('dd MMMM').format(bookingDate);
  return date;
}

String getTime(DateTime bookingDate) {
  String date = DateFormat('hh:mm a').format(bookingDate);
  return date;
}
