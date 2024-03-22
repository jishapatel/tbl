import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  final Function(bool) onEvent;

  const CustomAlertDialog({super.key, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/icons/close.svg',
                    width: 30.w,
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64.w,
                  height: 64.h,
                  child: Stack(
                    children: [
                      Container(
                        width: 64.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffddfff3),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/right_mark.svg',
                              width: 26.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                SizedBox(
                  width: 192.w,
                  child: Text(
                    "Your request for cancel table booking sent successfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff002f6c),
                      fontSize: 17.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
              ],
            ),
          ),
        )
      ],
    );
  }
}
