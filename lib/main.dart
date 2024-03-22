import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbl/screens/splash/splash_screen.dart';

import 'base/env/environment.dart';
import 'base/src_components.dart';
import 'base/src_constants.dart';
import 'base/utils/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;

  /// Set Environment
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);

  /// Firebase
  //await setFirebaseInit();
  /// Shared Preferences
  await SpUtil.getInstance();

  /// Set Portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return OTS(
      child: EzLocalizationBuilder(
          delegate: const EzLocalizationDelegate(
              supportedLocales: [Locale('en')], locale: Locale("en")),
          builder: (context, localizationDelegate) {
            return ScreenUtilInit(
              designSize: const Size(446, 960),
              builder: () => MaterialApp(
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
                debugShowCheckedModeBanner: false,
                title: "Structure",
                theme: normalTheme(context),
                home: SplashScreen(),
                navigatorKey: navigatorKey,
                localizationsDelegates:
                    localizationDelegate.localizationDelegates,
                supportedLocales: localizationDelegate.supportedLocales,
                localeResolutionCallback:
                    localizationDelegate.localeResolutionCallback,
              ),
            );
          }),
    );
  }
}
