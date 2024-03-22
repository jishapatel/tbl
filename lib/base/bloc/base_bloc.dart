import 'package:rxdart/rxdart.dart';

import '../src_components.dart';

abstract class BaseBloc {
  void dispose();
}

class BasePageBloc extends BaseBloc {
  PlaceHolderView emptyView = PlaceHolderView();
  PlaceHolderView errorView = PlaceHolderView();
  /*
   0 - BuildWidget
   1 - Loading
   2 - Empty
   3 - Error
   */
  late BehaviorSubject<int> placeHolderStatus;
  get placeHolderStatusStream => placeHolderStatus.stream;

  late BehaviorSubject<bool> isKeyboardVisible;
  get isKeyboardVisibleStream => isKeyboardVisible.stream;

  BasePageBloc() {
    placeHolderStatus = BehaviorSubject<int>.seeded(getInitialStatus());
    isKeyboardVisible = BehaviorSubject<bool>.seeded(false);
  }

  int getInitialStatus(){
    return 0;
  }

  void setPlaceHolderStatus(int status){
    if(!placeHolderStatus.isClosed){
      placeHolderStatus.add(status);
    }
  }

  /// Show Loading dialog
  void showLoadingDialog() {
    showLoader(isModal: true);
  }

  void hideLoadingDialog() {
    hideLoader();
  }

  /// Show Loading with background
  void showLoading() {
    setPlaceHolderStatus(1);
  }

  void hideLoading() {
    normalView();
  }

  /// Show Error View
  void showError(String title, Function() onRetry){
    errorView = PlaceHolderView(title: title,onRetry: onRetry);
    setPlaceHolderStatus(3);
  }

  /// Hide Error View
  void hideError(String title, Function() onRetry){
    errorView = PlaceHolderView();
    normalView();
  }

  /// Show Empty View
  void showEmpty(String title){
    emptyView = PlaceHolderView(title: title);
    setPlaceHolderStatus(2);
  }

  /// Hide Empty View
  void hideEmpty(String title){
    emptyView = PlaceHolderView();
    normalView();
  }

  void normalView() {
    setPlaceHolderStatus(0);
  }

  @override
  void dispose() {
    if (!isKeyboardVisible.isClosed) isKeyboardVisible.close();
    if (!placeHolderStatus.isClosed) placeHolderStatus.close();
  }
}
