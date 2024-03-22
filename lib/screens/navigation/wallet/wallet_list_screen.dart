import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';
import '../../../base/basePage.dart';
import '../../../base/bloc/base_bloc.dart';
import '../../../base/constants/app_colors.dart';
import '../../../base/constants/app_images.dart';
import '../../../base/remote/model/WalletHistoryResponse.dart';
import '../../../base/remote/model/wallet_amount_response.dart';
import '../../../base/utils/date_util.dart';
import '../../../base/widgets/custom_page_route.dart';
import '../../../base/widgets/image_view.dart';
import '../../billingDetails/billing_detail_screen.dart';
import '../../tbl_program/tbl_prog_screen.dart';
import 'wallet_list_screen_bloc.dart';

class WalletListScreen extends BasePage<WalletListScreenBloc> {
  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _WalletListState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => WalletListScreen());
  }
}

class _WalletListState
    extends BasePageState<WalletListScreen, WalletListScreenBloc> {
  WalletListScreenBloc bloc = WalletListScreenBloc();
  bool isNewUser = false;

  // @override
  // Widget? getAppBar() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     statusBarBrightness: Brightness.dark,
  //     statusBarIconBrightness: Brightness.dark,
  //   ));
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

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              if (!isNewUser)
                SizedBox(
                  height: 0,
                )
              else
                confettiView(),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 380.w,
                height: 170.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      end: Alignment(0.99, -0.17),
                      begin: Alignment(-0.99, 0.17),
                      colors: [Color(0xFF002A61), Color(0xCC003F92)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        //color: Color(0xFF002A61).withOpacity(0.2), // Shadow color
                        color: Color(0xFF002A61).withOpacity(0.2),
                        // Shadow color
                        spreadRadius: 2,
                        // Spread radius
                        blurRadius: 5,
                        // Blur radius
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ]),
                child: StreamBuilder<WalletAmountResponse?>(
                  stream: getBloc().walletAmountResponseStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return _mainBalanceView(snapshot.data!);
                    } else {
                      return Text(
                        "",
                        style: TextStyle(
                          color: Color(0xff002f6c),
                          fontSize: 23.sp,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 57.h,
              ),
              Row(
                children: [
                  Text(
                    "History",
                    style: TextStyle(
                      color: Color(0xff002f6c),
                      fontSize: 23.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, TblProgramScreen.route());
                    },
                    child: Row(
                      children: [
                        Text(
                          "TBL Loyalty Program",
                          style: TextStyle(
                            color: Color(0xffac145a),
                            fontSize: 19.sp,
                            //decoration: TextDecoration.underline,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          //padding: const EdgeInsets.only(right: 14),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 18.0,
                            color: MARUN,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              _walletTransactions()
            ],
          ),
        ),
      ),
    );
  }

  Widget _walletTransactions() {
    return Expanded(
      child: StreamBuilder<WalletHistoryResponse>(
        stream: getBloc().walletTransactionResponseStream,
        builder: (BuildContext context,
            AsyncSnapshot<WalletHistoryResponse> snapshot) {
          if (snapshot.hasData) {
            final reservationResponse = snapshot.data!;
            if (reservationResponse.walletHistories?.isEmpty == false) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reservationResponse.walletHistories?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return _itemRow(
                              snapshot.data!.walletHistories![index]);
                        } else {
                          return Text('No data available');
                        }
                      },
                    ),
                    //SizedBox(height: 29.h),
                  ],
                ),
              );
            } else {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                // Update the state here using setState()
                setState(() {
                  isNewUser = true;
                });
              });
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 350.h,
                  ),
                  Text(
                    "No wallet history available",
                    style: TextStyle(
                      color: BLUE,
                      fontSize: 23.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          } else {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 350.h,
                ),
                Text(
                  "No wallet history available",
                  style: TextStyle(
                    color: BLUE,
                    fontSize: 23.sp,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _mainBalanceView(WalletAmountResponse data) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 36, left: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total points",
                style: TextStyle(
                  color: Color(0xffeaeaea),
                  fontSize: 21.sp,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.balanceAmount.toString(),
                style: TextStyle(
                  color: Color(0xffeaeaea),
                  fontSize: 39.sp,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemRow(WalletHistory walletItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          BillingDetails.route(walletItem.id.toString()),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xfff7f8ff),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32.w,
                  height: 32.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3.w,
                          ),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/icons/wallet_item_icon.svg',
                                  width: 13,
                                  height: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill No. " + walletItem.id.toString(),
                      style: TextStyle(
                        color: Color(0xff002f6c),
                        fontSize: 19.sp,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      getDate(walletItem.processedAt!),
                      style: TextStyle(
                        color: Color(0xff011c3f),
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        (walletItem.earned_point != null)
                            ? "+ " + walletItem.earned_point.toString()
                            : "+  0",
                        style: TextStyle(
                          color: Color(0xff006341),
                          fontSize: 19.sp,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.60,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        (walletItem.redeemed_point != null)
                            ? "- " + walletItem.redeemed_point.toString()
                            : "",
                        style: TextStyle(
                          color: RED,
                          fontSize: 19.sp,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.60,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget confettiView() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            if (MediaQuery.of(context).size.width > 600) ...{
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80.h,
                child: ImageView(
                  image: AppImages.icConfetti,
                  imageType: ImageType.asset,
                  boxFit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, top: 25, right: 8, bottom: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Congratulations! 500 points has been added to the wallet as a sign up reward!',
                    style: TextStyle(
                      color: GREEN,
                      fontSize: 15.sp,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            },
            if (MediaQuery.of(context).size.width < 600) ...{
              ImageView(
                image: AppImages.icConfetti,
                imageType: ImageType.asset,
                boxFit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Congratulations! 500 points has been added to the wallet as a sign up reward!',
                    style: TextStyle(
                      color: GREEN,
                      fontSize: 15.sp,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }

  @override
  WalletListScreenBloc getBloc() {
    return bloc;
  }

  @override
  void initState() {
    super.initState();
    bloc.getWalletDetails(null, (response) {
      print(response);
      setState(() {
        _walletTransactions();
      }); // Update the widget after API call
    });
    bloc.getUserWalletAmount(null, (response) {
      print(response);
    });
  }

  String getDate(DateTime bookingDate) {
    String date = DateFormat('dd MMM yyyy').format(bookingDate);
    return date;
  }
}
