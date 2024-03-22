import 'package:rxdart/rxdart.dart';

import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/remote/model/billing_details_response.dart';
import '../../base/remote/repository/auth_repository.dart';

class BillingDetailScreenBloc extends BasePageBloc {
  late BehaviorSubject<BillingDetailsResponse> wallet;

  BillingDetailScreenBloc() {
    wallet = BehaviorSubject<BillingDetailsResponse>();
  }

  double cgstAmt = 0.0;
  double sgstAmt = 0.0;
  double discountAmt = 0.0;
  double subTotalAmt = 0.0;
  double serviceChargeAmt = 0.0;
  double grandTotalAmt = 0.0;

  BillingDetailsResponse? walletResponse;

  Stream<BillingDetailsResponse> get walletResponseStream => wallet.stream;

  void getWalletDetails(
      Map? data, String walletId, Function(BillingDetailsResponse) onSuccess) {
    showLoadingDialog();
    apiWalletDetails(data, walletId, (response) {
      hideLoadingDialog();
      walletResponse = response; // Assign the response directly
      wallet.add(walletResponse!);
      onSuccess.call(walletResponse!);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }
}
