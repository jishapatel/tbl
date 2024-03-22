import 'package:flutter/material.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_images.dart';
import '../../base/remote/model/billing_details_response.dart';
import '../../base/remote/model/billing_items.dart';
import '../../base/utils/date_util.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';
import 'billing_detail_screen_bloc.dart';

class BillingDetails extends BasePage<BillingDetailScreenBloc> {
  final String? key_billId;

  BillingDetails({super.key, this.key_billId});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _BillingDetailState();
  }

  static Route<dynamic> route(String? billId) {
    return CustomPageRoute(
        builder: (context) => BillingDetails(key_billId: billId));
  }
}

class _BillingDetailState
    extends BasePageState<BillingDetails, BillingDetailScreenBloc> {
  BillingDetailScreenBloc bloc = BillingDetailScreenBloc();

  @override
  void initState() {
    bloc.getWalletDetails(
        null,
        widget.key_billId.toString(),
        (response) => () {
              print(response);
            });
    super.initState();
  }

  @override
  Color scaffoldColor() {
    return Colors.white;
  }

  // @override
  // Widget buildWidget(BuildContext context) {
  //   return StreamBuilder<BillingDetailsResponse>(
  //     stream: getBloc().walletResponseStream,
  //     builder: (BuildContext context, AsyncSnapshot<BillingDetailsResponse> snapshot) {
  //       if (snapshot.hasData) {
  //         return Scaffold(
  //           appBar: AppBar(
  //             backgroundColor: Colors.white,
  //             leading: Padding(
  //               padding: EdgeInsets.only(left: 20.w),
  //               child: IconButton(
  //                 icon: Icon(
  //                   Icons.arrow_back_ios,
  //                   color: Colors.black,
  //                 ),
  //                 onPressed: () {
  //                   // Add your navigation logic here
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ),
  //             leadingWidth: 40.w,
  //             title: Text(
  //               "Bill no: ${getBloc().wallet.value.walletHistory.walletId}",
  //               style: TextStyle(
  //                 fontFamily: "Inter",
  //                 color: const Color(0xFF1E1F23),
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 19.sp,
  //               ),
  //             ),
  //             actions: [
  //               Center(
  //                 child: Container(
  //                   padding: EdgeInsets.only(right: 24.w),
  //                   child: Text(
  //                     getBloc().wallet.value.walletHistory.earnedPoint.toString() != "null"
  //                         ? '+ pt ${getBloc().wallet.value.walletHistory.earnedPoint}'
  //                         : "",
  //                     style: TextStyle(
  //                       color: const Color(0xFF006341),
  //                       fontSize: 18.sp,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           body: welcomeBlock(),
  //         );
  //       } else if (snapshot.hasError) {
  //         return const Center(child: Text('Error occurred'));
  //       } else {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }
  //
  @override
  Widget buildWidget(BuildContext context) {
    // return StreamBuilder<BillingDetailsResponse>(
    //     stream: getBloc().walletResponseStream,
    //     builder: (BuildContext context, AsyncSnapshot<BillingDetailsResponse> snapshot) {
    //       if (snapshot.hasData) {
    //         Scaffold(
    //             appBar: AppBar(
    //               backgroundColor: Colors.white,
    //               leading: Padding(
    //                 padding: EdgeInsets.only(left: 20.w),
    //                 child: IconButton(
    //                   icon: Icon(
    //                     Icons.arrow_back_ios,
    //                     color: Colors.black,
    //                   ),
    //                   onPressed: () {
    //                     // Add your navigation logic here
    //                     Navigator.pop(context);
    //                   },
    //                 ),
    //               ),
    //               leadingWidth: 40.w,
    //               title: Text(
    //                 "Bill no: ${getBloc().wallet.value.walletHistory.walletId}",
    //                 style: TextStyle(
    //                   fontFamily: "Inter",
    //                   color: const Color(0xFF1E1F23),
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 19.sp,
    //                 ),
    //               ),
    //               actions: [
    //                 Center(
    //                   child: Container(
    //                     padding: EdgeInsets.only(right: 24.w),
    //                     child: Text(
    //                       getBloc()
    //                                   .wallet
    //                                   .value
    //                                   .walletHistory
    //                                   .earnedPoint
    //                                   .toString() !=
    //                               "null"
    //                           ? '+ pt ${getBloc().wallet.value.walletHistory.earnedPoint}'
    //                           : "",
    //                       style: TextStyle(
    //                         color: const Color(0xFF006341),
    //                         fontSize: 18.sp,
    //                         fontFamily: 'Inter',
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             body: welcomeBlock());
    //       } else if (snapshot.hasError) {
    //         return const Center(child: Text('Error occurred'));
    //       } else {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //     });

    return StreamBuilder<BillingDetailsResponse>(
      stream: getBloc().walletResponseStream,
      builder: (BuildContext context,
          AsyncSnapshot<BillingDetailsResponse> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation:0.0,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Add your navigation logic here
                    Navigator.pop(context);
                  },
                ),
              ),
              leadingWidth: 40.w,
              title: Text(
                "Bill no: ${getBloc().wallet.value.walletHistory!.walletId}",
                style: TextStyle(
                  fontFamily: "Inter",
                  color: const Color(0xFF1E1F23),
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp,
                ),
              ),
              actions: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(right: 24.w),
                    child: Text(
                      getBloc()
                                  .wallet
                                  .value
                                  .walletHistory!
                                  .earnedPoint
                                  .toString() !=
                              "null"
                          ? '+ ${getBloc().wallet.value.walletHistory!.earnedPoint}'
                          : "",
                      style: TextStyle(
                        color: const Color(0xFF006341),
                        fontSize: 18.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: welcomeBlock(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );

    //return welcomeBlock();
  }

  @override
  BillingDetailScreenBloc getBloc() {
    return bloc;
  }

  Widget welcomeBlock() {
    return SingleChildScrollView(
      child: StreamBuilder<BillingDetailsResponse>(
          stream: getBloc().walletResponseStream,
          builder: (BuildContext context,
              AsyncSnapshot<BillingDetailsResponse> snapshot) {
            if (snapshot.data != null && snapshot.data!.billings!.isNotEmpty) {
              final reservationResponse = snapshot.data!;
              List<BillingItems> billingsList = [];
              // double cgstAmt = 0;
              // double sgstAmt = 0;
              for (var billing in reservationResponse.billings!) {
                getBloc().discountAmt =
                    getBloc().discountAmt + billing.discountAmount!;
                getBloc().serviceChargeAmt =
                    getBloc().serviceChargeAmt + billing.chargeAmount!;
                getBloc().subTotalAmt =
                    getBloc().subTotalAmt + billing.grossAmount!;
                getBloc().grandTotalAmt =
                    getBloc().grandTotalAmt + billing.totalAmount!;
                for (var item in billing.items!) {
                  getBloc().cgstAmt = getBloc().cgstAmt +
                      double.parse(item.taxes.first.totalTaxAmountFmt!);
                  getBloc().sgstAmt = getBloc().sgstAmt +
                      double.parse(item.taxes[1].totalTaxAmountFmt as String);
                  print("CGST:" + getBloc().cgstAmt.toString());
                  var billingItem = BillingItems(
                    id: item.menuItemId!.toInt(),
                    name: item.menuItemName.toString(),
                    price: item.grossAmount!.toDouble(),
                    qty: item.quantity!.toInt(),
                    category: item.ledgerCategory!.name.toString(),
                    //cgst: 0,
                    //sgst: 0,
                  );
                  billingsList.add(billingItem);
                }
              }
              return Column(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Stack( // Use Stack here
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 128.w,
                              height: 128.h,
                              child: ImageView(
                                image: AppImages.icLogoRound,
                                imageType: ImageType.asset,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          tableDetails(),
                          SizedBox(
                            height: 36.h,
                          ),
                          billItems(billingsList),
                          mainView(),
                        ],
                      ),
                    ],
                  ),
                  //rowItem(),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error occurred'));
            } else {
              //return const Center(child: CircularProgressIndicator());
              return const Center(child: Text("No Data Found"));
            }
          }),
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 24.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ImageView(
              height: 32.h,
              width: 32.w,
              image: AppImages.icBackWhite,
              imageType: ImageType.svg,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Center(
            child: Text(
              "Bill No. ${getBloc().wallet.value.walletHistory!.walletId}",
              style: TextStyle(
                fontFamily: "Inter",
                color: const Color(0xFF1E1F23),
                fontWeight: FontWeight.w500,
                fontSize: 19.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.only(right: 24.w),
                child: Text(
                  getBloc()
                              .wallet
                              .value
                              .walletHistory!
                              .earnedPoint
                              .toString() !=
                          "null"
                      ? '+ ${getBloc().wallet.value.walletHistory!.earnedPoint}'
                      : "",
                  style: TextStyle(
                    color: const Color(0xFF006341),
                    fontSize: 18.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget billItems(List<BillingItems> itemsList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            final walletItem = itemsList[index];
            print("<>" + itemsList.length.toString());
            //return rowItem(walletItem);
            return rowItem(walletItem);
          },
        ),
        SizedBox(height: 29.h),
      ],
    );
  }

  Widget mainView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Sub Total',
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  '₹' + (getBloc().subTotalAmt / 100).toStringAsFixed(2),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  //'Discount (20.00%)',
                  'Discount',
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  '₹' + (getBloc().discountAmt / 100).toStringAsFixed(2),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Service Charge',
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  '₹' + (getBloc().serviceChargeAmt / 100).toStringAsFixed(2),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'CGST',
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  "₹" + getBloc().cgstAmt.toStringAsFixed(2), //'₹0.43',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'SGST',
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  "₹" + getBloc().sgstAmt.toStringAsFixed(2), //'₹0.43',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Grand Total',
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 18.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    '₹' + (getBloc().grandTotalAmt / 100).toStringAsFixed(2),
                    //'₹246.00',
                    style: TextStyle(
                      color: Color(0xFF011C3F),
                      fontSize: 18.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget tableDetails() {
    DateTime? now = getBloc().wallet.value.billings!.first.businessDate;
    String date = DateFormat('dd/MM/yyyy').format(now!);

    return Column(
      children: [
        Text(
          'Table no : ' +
              getBloc().wallet.value.billings!.first.tableNo.toString(),
          style: TextStyle(
            color: Color(0xFF011C3F),
            fontSize: 24.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          date, //'08-July-2023',
          style: TextStyle(
            color: Color(0xFF011C3F),
            fontSize: 16.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(left: 24.w),
            child: Text(
              'Name: ${getBloc().wallet?.valueOrNull?.billings?.first?.customerName ?? ''}',
              style: TextStyle(
                color: Color(0xFF011C3F),
                fontSize: 16.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget rowItem(BillingItems walletItem) {
    return Container(
      //color: Colors.yellow,
      margin: EdgeInsets.only(left: 24.w, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  walletItem.name,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 18.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  (walletItem.price / 100).toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF011C3F),
                    fontSize: 18.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'X',
                  style: TextStyle(
                    color: Color(0x77011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: walletItem.qty.toString(),
                  style: TextStyle(
                    color: Color(0x7F011C3F),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
