import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbl/screens/navigation/profile/profile_screen.dart';
import 'package:tbl/screens/navigation/reservation/booking_list/bookings_list_screen.dart';
import 'package:tbl/screens/navigation/wallet/wallet_list_screen.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/utils/keepAlive.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../widgets/CustomBottomNavigationBar.dart';
import 'home/home_screen.dart';
import 'navigation_screen_bloc.dart';

class NavigationScreen extends BasePage<NavigationScreenBloc> {
  int selectedPageIndex = 0;

  NavigationScreen({Key? key, required this.selectedPageIndex})
      : super(key: key);

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _HomeScreenState();
  }

  static Route<dynamic> route({required int arguments}) {
    return CustomPageRoute(
      builder: (context) => NavigationScreen(selectedPageIndex: arguments),
    );
  }
}

class _HomeScreenState
    extends BasePageState<NavigationScreen, NavigationScreenBloc> {
  late PageController _pageController;
  int pageIndex = 0;
  NavigationScreenBloc bloc = NavigationScreenBloc();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    pageIndex = widget.selectedPageIndex;

    _pageController = PageController(initialPage: pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final pages = [
    KeepAlivePage(child: HomeScreen()),
    KeepAlivePage(child: WalletListScreen()),
    KeepAlivePage(child: BookingsList(onRefresh: () {})),
    KeepAlivePage(child: ProfileScreen()),
  ];

  @override
  Widget buildWidget(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        if (pageIndex != 0) {
          _pageController.jumpToPage(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: pageIndex,
          onItemSelected: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (pageIndex != index) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  NavigationScreenBloc getBloc() {
    return bloc;
  }
}
