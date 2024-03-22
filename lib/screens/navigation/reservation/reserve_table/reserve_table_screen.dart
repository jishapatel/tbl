import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';
import 'package:tbl/screens/navigation/reservation/reserve_table/reserve_table_screen_bloc.dart';

import '../../../../base/basePage.dart';
import '../../../../base/bloc/base_bloc.dart';
import '../../../../base/constants/app_colors.dart';
import '../../../../base/constants/app_images.dart';
import '../../../../base/constants/app_widgets.dart';
import '../../../../base/remote/model/slot_availability_response.dart';
import '../../../../base/utils/date_util.dart';
import '../../../../base/utils/shared_pref_utils.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../../../base/widgets/image_view.dart';
import '../../../common/info_dialog.dart';
import '../../navigation_screen.dart';
import '../booking_confirmation/booking_confirmation_screen.dart';

class ReserveTableScreen extends BasePage<ReserveTableScreenBloc> {
  ReserveTableScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _ReserveTableScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => ReserveTableScreen());
  }
}

class _ReserveTableScreenState
    extends BasePageState<ReserveTableScreen, ReserveTableScreenBloc> {
  late List<DateTime> timeItems = [];
  ReserveTableScreenBloc bloc = ReserveTableScreenBloc();
  int selectedIndexForDate = 0;
  int selectedIndexForTime = 0;
  int selectedIndexForArea = 0;
  int selectedIndexForPreferredArea = 0;
  int quantity = 1;
  String selectedArea = '';
  String selectedPreferredArea = '';
  String floorPreferredArea = '';
  String selectedGuest = '';
  String selectedTime = '';
  String selectedDate = '';
  String selectedGuests = '';
  bool isButtonEnabled = false;
  int tablesLeft = 0;

  void incrementQuantity() {
    setState(() {
      if (quantity < 25) {
        quantity++;
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  void dispose() {
    // Add any cleanup code here
    WidgetsBinding.instance.removeObserver(context as WidgetsBindingObserver);
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    updateData();

    print("total items = " + timeItems.length.toString());
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          Future.delayed(Duration(milliseconds: 50), () {
            Navigator.pop(context);
          });
          return false;
        },
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    textDirection: TextDirection.rtl,
                    fit: StackFit.loose,
                    clipBehavior: Clip.hardEdge,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/reserve_table.png',
                        width: MediaQuery.of(context).size.width,
                        height: 279.h,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 39.44, left: 24, right: 24),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  NavigationScreen.route(arguments: 2),
                                  (route) => false,
                                );
                              },
                              child: Container(
                                width: 45,
                                // Adjust the size as needed
                                height: 45,
                                // Adjust the size as needed
                                // decoration: BoxDecoration(
                                //   shape: BoxShape.circle,
                                //   color: Colors.transparent.withOpacity(
                                //       0.5), // Transparent gray color
                                // ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: ImageView(
                                        image: AppImages.icBackWhite,
                                        imageType: ImageType.svg,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // child: ImageView(
                              //   image: AppImages.icBackWhite,
                              //   imageType: ImageType.svg,
                              // ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Reserve Table",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    color: GREY1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 21.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 17, left: 24),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hurry! $tablesLeft tables left for today!',
                    style: TextStyle(
                      color: BLUE,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 23.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  //height: 500,
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateView(),
                      SizedBox(
                        height: 36.h,
                      ),
                      if (timeItems.isNotEmpty) timeView(),
                      if (timeItems.isEmpty)
                        Text(
                          'No Slot Available',
                          style: TextStyle(
                            color: BLUE,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 21.sp,
                          ),
                        ),
                      SizedBox(
                        height: 36.h,
                      ),
                      areaView(),
                      SizedBox(
                        height: 36.h,
                      ),
                      preferredAreaView(),
                      SizedBox(
                        height: 36.h,
                      ),
                      guestView(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: previewReservationButton(),
            ),
          ],
        ),
      ),
    );
    //);
  }

  @override
  ReserveTableScreenBloc getBloc() {
    return bloc;
  }

  updateData() {
    onSlotAvailability();
    timeItems.clear();

    if (selectedDate == '') {
      selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
    final currentDate = DateTime.now();
    final date = DateFormat('dd/MM/yyyy').parse(selectedDate);
    List<DateTime> listOfTimes = List.generate(
      24 * 2,
      (index) => DateTime(
        date.year,
        date.month,
        date.day,
        (index ~/ 2),
        (index % 2) * 30,
      ),
    );

    List<String> dateTimeArray = date.toString().split(' ');
    String dateTimeWithoutSpace = dateTimeArray.first;
    DateTime dateTime = DateTime.parse(dateTimeWithoutSpace);

    List<String> currentDateTimeArray = currentDate.toString().split(' ');
    String currentDateTimeWithoutSpace = currentDateTimeArray.first;
    DateTime currentDateTime = DateTime.parse(currentDateTimeWithoutSpace);

    if (selectedDate.isNotEmpty && dateTime == currentDateTime) {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      String formattedTime = formatter.format(now);

      DateTime dateTime = formatter.parse(formattedTime);

      //DateTime now = DateTime.now();
      DateTime targetTime = DateTime(now.year, now.month, now.day, 11, 30);

      if (now.isAfter(targetTime)) {
        for (DateTime time in listOfTimes) {
          if (time.isAfter(dateTime)) {
            print("called 263");
            timeItems.add(time);
          }
        }
      } else {
        timeItems.clear();
        print("called 269");
        List<DateTime> filteredList = listOfTimes
            .where((time) => time.isAfter(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day, 11, 30)))
            .toList();
        timeItems.addAll(filteredList);
      }
    } else {
      timeItems.clear();

      // List<DateTime> filteredList = listOfTimes
      //     .where((time) => time.isAfter(DateTime(DateTime.now().year,
      //         DateTime.now().month, DateTime.now().day, 11, 30)))
      //     .toList();
      // Filter the list of dates to include only the selected date.

      List<DateTime> listOfTime = List.generate(
        24 * 2,
        (index) => DateTime(
          date.year,
          date.month,
          date.day,
          (index ~/ 2),
          (index % 2) * 30,
        ),
      );
      List<DateTime> filteredList = listOfTime
          .where((time) =>
              time.year == date.year &&
              time.month == date.month &&
              time.day == date.day &&
              time.hour > 11 &&
              time.minute >= 0)
          .toList();

      timeItems.addAll(filteredList);

      print(timeItems.length.toString() + DateTime.now().toString());
      print("total items = " + timeItems.length.toString());
      print("called 308");
    }
  }

  dateView() {
    final currentDate = DateTime.now();
    final List<String> items = [];

    for (int i = 0; i < 7; i++) {
      final date = currentDate.add(Duration(days: i));
      final formattedDay = DateFormat('EEE').format(date);
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      items.add(formattedDay + '\n' + formattedDate);
    }

    // Check if no date is selected, then select the default date
    if (selectedIndexForDate == 0 && selectedDate.isEmpty) {
      selectedIndexForDate = 0;
      selectedDate = items[0].split('\n')[1];
      onSlotAvailability();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: TextStyle(
            color: BLUE,
            fontStyle: FontStyle.normal,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 21.sp,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8,
              children: List.generate(items.length, (index) {
                final borderRadius = BorderRadius.circular(6);
                final item = items[index];
                final isSelected = selectedIndexForDate == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexForDate = index;
                      selectedDate = item.split('\n')[1];
                    });
                    updateData();
                    onSlotAvailability();
                  },
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Container(
                      color: isSelected ? BLUE : LIGHT_BLUE2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                        child: Column(
                          children: <Widget>[
                            Text(
                              item.split('\n')[0],
                              style: TextStyle(
                                color: isSelected ? Colors.white : BLUE,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              item.split('\n')[1].split('/')[0],
                              style: TextStyle(
                                color: isSelected ? Colors.white : BLUE,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  String getTime(DateTime timeItem) {
    final time = DateFormat('HH:mm').format(timeItem);
    return time;
  }

  timeView() {
    //updateData();
    if (selectedIndexForTime == 0 && selectedTime.isEmpty) {
      selectedIndexForTime = 0;
      selectedTime = getTime(timeItems[0]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: TextStyle(
            color: BLUE,
            fontStyle: FontStyle.normal,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 21.sp,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          height: 44.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: timeItems.length,
            itemBuilder: (context, index) {
              final borderRadius = BorderRadius.circular(6);
              final isLastItem = index == timeItems.length - 1;
              final item = getTime(timeItems[index]);
              final isSelected = selectedIndexForTime == index;

              return Padding(
                padding: EdgeInsets.only(right: isLastItem ? 0 : 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexForTime = index;
                      selectedTime = item as String;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Container(
                      color: isSelected ? BLUE : LIGHT_BLUE2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              item as String,
                              style: TextStyle(
                                color: isSelected ? Colors.white : BLUE,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  areaView() {
    final areaItems = ['Smoking Area', 'No Smoking Area'];

    if (selectedIndexForArea == 0 && selectedArea.isEmpty) {
      selectedIndexForArea = 0;
      selectedArea = areaItems[0];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Area',
          style: TextStyle(
            color: BLUE,
            fontStyle: FontStyle.normal,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 21.sp,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8,
              children: List.generate(areaItems.length, (index) {
                final borderRadius = BorderRadius.circular(6);
                final item = areaItems[index];
                final isSelected = selectedIndexForArea == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexForArea = index;
                      selectedArea = item;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Container(
                      height: 110.h,
                      color: isSelected ? BLUE : LIGHT_BLUE2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                        child: Column(
                          children: <Widget>[
                            ImageView(
                              image: isSelected
                                  ? (item == "Smoking Area"
                                      ? AppImages.icSmokingWhite
                                      : AppImages.icNonSmokingWhite)
                                  : (item == "Smoking Area"
                                      ? AppImages.icSmokingBlue
                                      : AppImages.icNonSmokingBlue),
                              imageType: ImageType.svg,
                            ),
                            SizedBox(height: 15.5.h),
                            Text(
                              item,
                              style: TextStyle(
                                color: isSelected ? Colors.white : BLUE,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  preferredAreaView() {
    final preferredAreaItems = [
      'Courtyard Barrel',
      'Beer Garden (smoking allowed)',
      'Ground Floor',
      'Mezzanine',
      'First Floor',
      'Rooftop (smoking allowed)'
    ];

    if (selectedIndexForPreferredArea == 0 && selectedPreferredArea.isEmpty) {
      selectedIndexForPreferredArea = 0;
      selectedPreferredArea = preferredAreaItems[0];
      //floorPreferredArea = "1";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred area',
          style: TextStyle(
            color: BLUE,
            fontStyle: FontStyle.normal,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 21.sp,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(preferredAreaItems.length, (index) {
                final borderRadius = BorderRadius.circular(6);
                final isLastItem = index == preferredAreaItems.length - 1;
                final item = preferredAreaItems[index];
                final isSelected = selectedIndexForPreferredArea == index;

                return Padding(
                  padding: EdgeInsets.only(right: isLastItem ? 0 : 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndexForPreferredArea = index;
                        //floorPreferredArea = (index+1) as String;
                        selectedPreferredArea = item;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Container(
                        color: isSelected ? BLUE : LIGHT_BLUE2,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : BLUE,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  previewReservationButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19, top: 19, left: 24, right: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isButtonEnabled ? Color.fromARGB(255, 255, 152, 0) : Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 0,
        ),
        onPressed: isButtonEnabled
            ? () {
                Future.delayed(Duration(milliseconds: 100), () {
                  if (selectedTime != '') {
                    _showBottomSheet(context);
                  } else {
                    showMessageBar("Please Select time");
                  }
                });
              }
            : null,
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            "Preview Reservation",
            style: TextStyle(
                fontSize: 20.sp, color: Colors.white, fontFamily: 'Inter'),
          ),
        ),
      ),
    );
  }

  guestView() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Guest',
              style: TextStyle(
                color: BLUE,
                fontStyle: FontStyle.normal,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 21.sp,
              ),
            ),
            Row(
              children: [
                // Button to increase quantity
                GestureDetector(
                  onTap: () {
                    decrementQuantity();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      color: BLUE,
                      padding: const EdgeInsets.all(7.3),
                      child: ImageView(
                        image: AppImages.icMinus,
                        imageType: ImageType.svg,
                      ),
                    ),
                  ),
                ),
                // Display the quantity value (default is 0)
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    quantity.toString(),
                    style: TextStyle(
                      color: BLUE,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 21.sp,
                    ),
                  ),
                ),
                // Button to decrease quantity
                GestureDetector(
                  onTap: () {
                    incrementQuantity();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      color: BLUE,
                      padding: const EdgeInsets.all(7.33),
                      child: ImageView(
                        image: AppImages.icPLus,
                        imageType: ImageType.svg,
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
        SizedBox(
          height: 19.h,
        ),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "*Maximum 25 and Minimum 1 guest is allowed per table",
            style: TextStyle(
              color: Color.fromARGB(255, 200, 16, 46),
              fontStyle: FontStyle.normal,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: IntrinsicHeight(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, right: 39, left: 39),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Confirm Booking",
                              style: TextStyle(
                                color: BLUE1,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 23.sp,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            onSlotAvailability();
                          },
                          child: ImageView(
                            image: AppImages.icClose,
                            imageType: ImageType.svg,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(58.5, 28, 58.5, 28),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Date of Booking: ",
                                style: TextStyle(
                                  color: BLUE1,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                            Text(
                              selectedDate,
                              style: TextStyle(
                                color: BLUE1,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                fontSize: 19.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Time to visit:",
                                style: TextStyle(
                                  color: BLUE1,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                            Text(
                              formatTime(selectedTime),
                              style: TextStyle(
                                color: BLUE1,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                fontSize: 19.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Area",
                                style: TextStyle(
                                  color: BLUE1,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                            Text(
                              selectedArea,
                              style: TextStyle(
                                color: BLUE1,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                fontSize: 19.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "No. of guests:",
                                style: TextStyle(
                                  color: BLUE1,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                            Text(
                              quantity.toString(),
                              style: TextStyle(
                                color: BLUE1,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                fontSize: 19.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Preferred zone:",
                                style: TextStyle(
                                  color: BLUE1,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                selectedPreferredArea,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: BLUE1,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: confirmButton(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatTime(String time) {
    final hour = int.parse(time.split(':')[0]);
    final minute = int.parse(time.split(':')[1]);
    final isAm = hour < 12;

    if (hour == 0) {
      return '12:${minute.toString().padLeft(2, '0')} ${isAm ? 'pm' : 'pm'}';
    } else if (hour == 12) {
      return '12:${minute.toString().padLeft(2, '0')} ${isAm ? 'pm' : 'pm'}';
    } else {
      final formattedHour = (hour % 12).toString().padLeft(2, '0');
      return '$formattedHour:${minute.toString().padLeft(2, '0')} ${isAm ? 'pm' : 'pm'}';
    }
  }

  void onSlotAvailability() {
    hideKeyboard(context);
    Map<String, dynamic>? requestData;
    requestData = {"availabilty_date": selectedDate};

    getBloc().doSlotAvailability(requestData, (response) {
      final slotAvailabilityResponse = response as SlotAvailabilityResponse;

      if (slotAvailabilityResponse.totalBookings <
          slotAvailabilityResponse.maximumAllowedBookings) {
        setState(() {
          isButtonEnabled = true; // Enable the button
          tablesLeft = slotAvailabilityResponse.maximumAllowedBookings -
              slotAvailabilityResponse.totalBookings;
        });
      } else {
        setState(() {
          isButtonEnabled = false; // Disable the button
        });
      }
    });
  }

  void onSlotAvailabilityConfirmBooking() {
    hideKeyboard(context);
    Map<String, dynamic>? requestData;
    requestData = {"availabilty_date": selectedDate};

    getBloc().doSlotAvailability(requestData, (response) {
      final slotAvailabilityResponse = response as SlotAvailabilityResponse;

      if (slotAvailabilityResponse.totalBookings <
          slotAvailabilityResponse.maximumAllowedBookings) {
        setState(() {
          String floor = "1";
          if (selectedPreferredArea == '1st Floor') {
            floor = "1";
          } else if (selectedPreferredArea == '2nd Floor') {
            floor = "2";
          } else {
            floor = "3";
          }
          String tempDate =
              selectedDate + " " + formatTime(selectedTime).toUpperCase();
          String bookindDate = SPDateUtils.formatDate(tempDate);

          final Map<String, dynamic> bookingData = {
            'booking': {
              'user_id': getUserID(),
              'no_of_people': quantity.toString(),
              'booking_date': bookindDate,
              'booking_area_type': selectedArea,
              'booking_floor': floor,
              'restaurant_id': "1",
            }
          };

          getBloc().createReservation(bookingData, (response) {
            if (response.message == "Booking Request Created Successfully") {
              Navigator.push(context, BookingConfirmationScreen.route());
            } else {
              showMessageBar(response.message ?? "");
            }
          });
        });
      } else {
        setState(() {
          showDialog(
              context: context,
              builder: (context) {
                return InfoAlertDialog();
              });
        });
      }
    });
  }

  Widget confirmButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 152, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 0,
        ),
        onPressed: () => {
          onSlotAvailabilityConfirmBooking()
          //Navigator.push(context, BookingConfirmationScreen.route())
        },
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            "Confirm",
            style: TextStyle(
                fontSize: 20.sp,
                //fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'Inter'),
          ),
        ),
      ),
    );
  }
}

class Data {
  String name;
  String imageURL;

  Data({required this.name, required this.imageURL});
}
