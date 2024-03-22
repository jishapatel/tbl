import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:lottie/lottie.dart';

import '../../base/utils/shared_pref_utils.dart';
import '../navigation/navigation_screen.dart';
import '../welcome/WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      print(info);
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate()
            .whenComplete(() => print("download completed"))
            .then((_) {
          showSnack("Success!");
        }).catchError((e) {
          showSnack(e.toString());
        });
      }
      // _updateInfo = info;

      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
      print("error");
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return splashImage();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //       //navigateToHome();
  //       _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
  //           ? () {
  //               InAppUpdate.performImmediateUpdate()
  //                   .catchError((e) => showSnack(e.toString()));
  //             }
  //           : navigateToHome();
  //     });
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }
  //
  // void showSnack(String text) {
  //   if (_scaffoldKey.currentContext != null) {
  //     ScaffoldMessenger.of(_scaffoldKey.currentContext!)
  //         .showSnackBar(SnackBar(content: Text(text)));
  //   }
  // }

  Widget splashImage() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Hide the status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Center(
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Lottie.asset('assets/splash_.json',
              height: MediaQuery.of(context).size.height,
              repeat: false, reverse: false,fit: BoxFit.fill),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (checkForUpdate() == true) {
    } else {
      navigateToHome();
    }

    // _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
    //     ? () {
    //   InAppUpdate.performImmediateUpdate()
    //       .whenComplete(() => showSnack("completed download"))
    //       .catchError((e) {
    //     showSnack(e.toString());
    //     return AppUpdateResult.inAppUpdateFailed;
    //   });
    // }
    //     : null;
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {
      if (isLogin()) {
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   NavigationScreen.route(),
        //       (route) => false,
        // );
        Navigator.pushAndRemoveUntil(
          context,
          NavigationScreen.route(arguments: 0),
          (route) => false,
        );
        // Navigator.pushAndRemoveUntil(context, BookingsList.route(),(route) => false,);
      } else {
        Navigator.pushReplacement(context, WelcomeScreen.route());
      }
    });
  }
}
