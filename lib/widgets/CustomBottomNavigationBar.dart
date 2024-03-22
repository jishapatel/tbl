import 'package:flutter/material.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../base/constants/app_colors.dart';
import '../base/constants/app_images.dart';
import '../base/widgets/image_view.dart';
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(color: GREY1, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(image: AppImages.icHomeUnelected, imageType: ImageType.svg,))),
            label: 'Home',
            activeIcon: Container(
                decoration: BoxDecoration(color: BLUE, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(image: AppImages.icHomeSelected, imageType: ImageType.svg,))),
          ),
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(color: GREY1, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(image: AppImages.icWalletUnselected, imageType: ImageType.svg,))),
            label: 'Wallet',
            activeIcon: Container(
                decoration: BoxDecoration(color: BLUE, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14), child: ImageView(image: AppImages.icWalletSelected, imageType: ImageType.svg,))),
          ),
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(color: GREY1, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(
                      image: AppImages.icReservationUnselected,
                      imageType: ImageType.svg,
                    ))),
            label: 'Reservation',
            activeIcon: Container(
                decoration: BoxDecoration(color: BLUE, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(
                      image: AppImages.icReservationSelected,
                      imageType: ImageType.svg,
                    ))),
          ),
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(color: GREY1, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(
                      image: AppImages.icProfileUnselected,
                      imageType: ImageType.svg,
                    ))),
            label: 'Profile',
            //labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Set the desired font size and weight
            activeIcon: Container(
                decoration: BoxDecoration(color: BLUE, shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ImageView(
                      image: AppImages.icProfileSelected,
                      imageType: ImageType.svg,
                    ))),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: BLUE,
        unselectedItemColor: BLUE,
        selectedLabelStyle: TextStyle(
          fontFamily: "Inter",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        onTap: onItemSelected,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 28),
        selectedFontSize: 16.sp,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
