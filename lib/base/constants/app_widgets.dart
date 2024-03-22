import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../src_constants.dart';

/// to get main navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// to get all app context
final BuildContext globalContext = navigatorKey.currentState!.context;

/// base image asset
imageAsset(context, path, {width, height, color, fit = BoxFit.contain}) =>
    Image.asset("assets/images/$path",
        width: width,
        height: height,
        color: color,
        fit: fit);

/// base image asset
assetImage(context, path) =>
    AssetImage('assets/images/$path');

/// hide keyboard
hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

/// show const back arrow
backArrow(context, {onTap, arrowColor = BLACK, path = 'left_arrow'}) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: imageAsset(context, path,
                  height: 20.0,
                  width: 20.0,
                  color: arrowColor ?? BLACK))));
}

showMessageBar(String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.GROUNDED,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    messageText: Text(
      message,
      maxLines: 3,
      style: styleMedium2.copyWith(
          color: WHITE
      ),
    ),
  ).show(globalContext);
}

showErrorMessageBar(String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 98),
    isDismissible: true,
    duration: const Duration(seconds: 3),
    borderRadius: const BorderRadius.all(Radius.circular(6)),
    backgroundColor: Colors.grey,
    messageText: Text(
      message,
      maxLines: 3,
      style: styleMedium3.copyWith(color: BLACK),
    ),
  ).show(globalContext);
}