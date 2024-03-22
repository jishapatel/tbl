import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:tbl/base/widgets/progress_view.dart';

import 'bloc/base_bloc.dart';
import 'bloc/base_bloc_provider.dart';
import 'components/error_empty_view.dart';
import 'components/loader_overlay/ots.dart';
import 'constants/app_colors.dart';

abstract class BasePage<T extends BasePageBloc?> extends StatefulWidget {
  BasePage({Key? key, this.bloc}) : super(key: key);

  final BasePageBloc? bloc;

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage, B extends BasePageBloc>
    extends State<T> /*with WidgetsBindingObserver*/ {
  bool _isPaused = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ThemeData? themeData;

  State get state => this;

  Widget buildWidget(BuildContext context);

  B getBloc();

  @override
  void initState() {
    super.initState();
    getBloc();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    // WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!getBloc().isKeyboardVisible.isClosed) {
        getBloc().isKeyboardVisible.add(visible);
      }
    });
  }

  ThemeData? getThemeData() {
    return themeData;
  }

  /// Implement your code here
  void onResume() {
    // TODO: Implement your code here
  }

  /// Implement your code here
  void onReady() {
    // TODO: Implement your code here
  }

  /// Implement your code here
  void onPause() {
    // TODO: Implement your code here
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     if (!_isPaused) {
  //       onPause();
  //     }
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (!_isPaused) {
  //       onResume();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return BlocProvider<B>(
        initBloc: getBloc(),
        child: WillPopScope(
            onWillPop: () async => onWillPopScope(),
            child: getCustomScaffold()));
  }

  Widget getCustomScaffold() {
    if (isRemoveScaffold()) {
      return buildWidget(context);
    } else {
      return getScaffold();
    }
  }

  Scaffold getScaffold() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: getAppBar() as PreferredSizeWidget?,
      body: getBaseView(context),
      drawer: getDrawer(),
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: getBottomNavigationBar(),
      bottomSheet: getBottomSheet(),
    );
  }

  // Color scaffoldColor() {
  //   return themeData!.scaffoldBackgroundColor;
  // }

  Color progressColor() {
    return ACCENT_COLOR;
  }

  Color errorTextColor() {
    return BLACK;
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  bool isRemoveScaffold() => false;

  Future<void> onRefresh() {
    return Future.value(null);
  }

  bool isRefreshEnable() => false;

  Future<bool> onWillPopScope() async {
    FocusScope.of(context).unfocus();
    if (isOTSLoading()) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Widget getBaseStackView() {
    return StreamBuilder<int>(
        stream: getBloc().placeHolderStatusStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data == 0) {
              return buildWidget(context);
            } else if (snapshot.data == 1) {
              return _getBaseLoadingWidget();
            } else if (snapshot.data == 2) {
              return _getBaseEmptyWidget();
            } else if (snapshot.data == 3) {
              return _getBaseErrorWidget();
            } else {
              return buildWidget(context);
            }
          } else {
            return Container();
          }
        });
  }

  Widget getBaseView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: isRefreshEnable()
          ? RefreshIndicator(
              onRefresh: onRefresh,
              child: getBaseStackView(),
            )
          : getBaseStackView(),
    );
  }

  Widget _getBaseErrorWidget() {
    return QuickView.error(
      title: getBloc().errorView.title,
      onRetry: getBloc().errorView.onRetry,
      textColor: errorTextColor(),
    );
  }

  Widget _getBaseLoadingWidget() {
    return Center(child: ProgressView(color: progressColor()));
  }

  Widget _getBaseEmptyWidget() {
    return QuickView.empty(
      title: getBloc().emptyView.title,
      textColor: errorTextColor(),
    );
  }

  Widget? getBottomNavigationBar() {
    return null;
  }

  Widget? getBottomSheet() {
    return null;
  }

  Widget? getDrawer() {
    return null;
  }

  Widget? buildFloatingActionButton() {
    return null;
  }

  Widget? getAppBar() {
    return null;
  }

  void hideSoftInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
