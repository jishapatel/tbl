import 'package:flutter/material.dart';

import '../../src_widgets.dart';

BuildContext? getOTSContext() {
  return _tKey.currentContext;
}

bool isOTSLoading() {
  return _loaderShown;
}

/// This will be used as a key for getting the [context] of [OTS] widget
/// which is used for inserting the [OverlayEntry] into an [Overlay] widget
final GlobalKey _tKey = GlobalKey(debugLabel: 'overlay_parent');
final _modalBarrierDefaultColor = Colors.black.withOpacity(0.5);

/// Updates with the latest [OverlayEntry] child
OverlayEntry? _notificationEntry;
OverlayEntry? _loaderEntry;
OverlayEntry? _networkStatusEntry;

/// is dark theme
bool isDarkTheme = false;

bool _notificationShown = false;
bool _loaderShown = false;
bool _networkShown = false;

bool _showDebugLogs = false;

Widget? _loadingIndicator;

class OTS extends StatelessWidget {
  final Widget? child;
  final Widget? loader;
  final bool darkTheme;

  const OTS({Key? key, this.child, this.loader, this.darkTheme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _loadingIndicator = loader;
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;
  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState?;
    } else {
      element.visitChildElements(visitor);
    }
  }

  context.visitChildElements(visitor);

  assert(navigator != null,
  '''Cannot find OTS above the widget tree, unable to show overlay''');
  return navigator!.overlay;
}

Future<void> showLoader({bool isModal = false,
  Color? modalColor,
  bool modalDismissible = true}) async {
  try {
    _printLog('''Showing loader as Overlay''');
    final _child = Center(
      child: _loadingIndicator ?? ProgressView(),
    );
    await _showOverlay(
      child: isModal
          ? Stack(
        children: <Widget>[
          ModalBarrier(
            color: modalColor ?? _modalBarrierDefaultColor,
            dismissible: modalDismissible,
          ),
          _child
        ],
      )
          : _child,
      type: _OverlayType.Loader,
    );
  } catch (err) {
    debugPrint(
        '''Caught an exception while trying to show a Loader\n${err
            .toString()}''');
    throw err;
  }
}

Future<void> hideLoader() async {
  try {
    _printLog('''Hiding loader overlay''');
    await _hideOverlay(_OverlayType.Loader);
  } catch (err) {
    _printError('''Caught an exception while trying to hide loader''');
    throw err;
  }
}


/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({required Widget child, _OverlayType? type}) async {
  try {
    final overlay = _overlayState;

    if (type!.isShowing()) {
      _printLog('''An overlay of ${type.name()} is already showing''');
      return Future.value(false);
    }

//    try {
//      if (_overlayShown) hideOverlay();
//    } catch (err) {
//      print(err);
//    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay!.insert(overlayEntry);
    type.setOverlayEntry(overlayEntry);
    type.setShowing();
  } catch (err) {
    _printError(
        '''Caught an exception while trying to insert Overlay\n${err
            .toString()}''');
    throw err;
  }
}

Future<void> _hideOverlay(_OverlayType type) async {
  try {
    if (type.isShowing()) {
      type.getOverlayEntry()?.remove();
      type.hide();
    } else {
      _printLog('No overlay is shown');
    }
  } catch (err) {
    _printError(
        '''Caught an exception while trying to remove Overlay\n${err
            .toString()}''');
    throw err;
  }
}

void _printLog(String log) {
  if (_showDebugLogs) debugPrint(log);
}

void _printError(String log) {
  debugPrint(log);
}

/// ----------------------------- end overlay methods --------------------------
enum _OverlayType {
  Notification,
  Loader,
  NetworkStatus,
}

extension OverlayTypeExtension on _OverlayType {
  String name() {
    switch (this) {
      case _OverlayType.Notification:
        return "Notification";
      case _OverlayType.Loader:
        return "Loader";
      case _OverlayType.NetworkStatus:
        return "NetworkStatus";
    }
  }

  bool isShowing() {
    switch (this) {
      case _OverlayType.Notification:
        return _notificationShown;
      case _OverlayType.Loader:
        return _loaderShown;
      case _OverlayType.NetworkStatus:
        return _networkShown;
    }
  }

  void setShowing() {
    switch (this) {
      case _OverlayType.Notification:
        _notificationShown = true;
        break;
      case _OverlayType.Loader:
        _loaderShown = true;
        break;
      case _OverlayType.NetworkStatus:
        _networkShown = true;
        break;
    }
  }

  void hide() {
    switch (this) {
      case _OverlayType.Notification:
        _notificationShown = false;
        break;
      case _OverlayType.Loader:
        _loaderShown = false;
        break;
      case _OverlayType.NetworkStatus:
        _networkShown = false;
        break;
    }
  }

  OverlayEntry? getOverlayEntry() {
    switch (this) {
      case _OverlayType.Notification:
        return _notificationEntry;
      case _OverlayType.Loader:
        return _loaderEntry;
      case _OverlayType.NetworkStatus:
        return _networkStatusEntry;
    }
  }

  void setOverlayEntry(OverlayEntry entry) {
    switch (this) {
      case _OverlayType.Notification:
        _notificationEntry = entry;
        break;
      case _OverlayType.Loader:
        _loaderEntry = entry;
        break;
      case _OverlayType.NetworkStatus:
        _networkStatusEntry = entry;
        break;
    }
  }
}

class OverlayWidget extends StatelessWidget {
  final String description;

  OverlayWidget({this.description = ''});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        bottom: true,
        top: false,
        child: Container(
            child: Expanded(
              child: description == null
                  ? Container()
                  : Text(
                description,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'WorksSans'),
              ),
            )),
      ),
    );
  }
}
