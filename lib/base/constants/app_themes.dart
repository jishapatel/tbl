import 'package:flutter/material.dart';

import '../src_constants.dart';

normalTheme(BuildContext context) {
  return ThemeData(
    fontFamily: FONT_FAMILY_POPPINS,
    primaryColor: Colors.orange,
    primarySwatch: Colors.orange,
    colorScheme: ColorScheme.light(primary: Colors.orange),
    hintColor: ACCENT_COLOR,
    disabledColor: Colors.grey,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.white,
      selectionHandleColor: Colors.black,
    ),
    brightness: Brightness.light,
    buttonTheme: Theme
        .of(context)
        .buttonTheme
        .copyWith(
        colorScheme: const ColorScheme.light(),
        buttonColor: Colors.black,
        splashColor: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
  );
}

lightTheme(BuildContext context) {
  return ThemeData(
    fontFamily: FONT_FAMILY_POPPINS,
    primarySwatch: Colors.orange,
    primaryColor: Colors.white,
    hintColor: Colors.orange,
    disabledColor: Colors.grey,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: Theme
        .of(context)
        .buttonTheme
        .copyWith(
        colorScheme: const ColorScheme.light(),
        buttonColor: Colors.orange,
        splashColor: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
  );
}

darkTheme(BuildContext context) {
  return ThemeData(
    fontFamily: FONT_FAMILY_POPPINS,
    primarySwatch: Colors.orange,
    primaryColor: ACCENT_COLOR,
    hintColor: ACCENT_COLOR,
    disabledColor: Colors.grey,
    cardColor: Color(0xff1f2124),
    scaffoldBackgroundColor: ACCENT_COLOR,
    canvasColor: ACCENT_COLOR,
    brightness: Brightness.dark,
    buttonTheme: Theme
        .of(context)
        .buttonTheme
        .copyWith(
        colorScheme: const ColorScheme.dark(),
        buttonColor: Colors.orange,
        splashColor: Colors.black),
    appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: ACCENT_COLOR
    ),
  );
}