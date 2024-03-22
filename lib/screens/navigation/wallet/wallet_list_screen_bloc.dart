import 'package:rxdart/rxdart.dart';

import '../../../base/bloc/base_bloc.dart';
import '../../../base/remote/model/WalletHistoryResponse.dart';
import '../../../base/remote/model/wallet_amount_response.dart';
import '../../../base/remote/repository/auth_repository.dart';

class WalletListScreenBloc extends BasePageBloc {
  late BehaviorSubject<WalletHistoryResponse> walletTransactionList;
  late BehaviorSubject<WalletAmountResponse> walletAmount;

  WalletListScreenBloc() {
    walletTransactionList = BehaviorSubject<WalletHistoryResponse>();
    walletAmount = BehaviorSubject<WalletAmountResponse>();
  }

  Stream<WalletHistoryResponse> get walletTransactionResponseStream =>
      walletTransactionList.stream;

  Stream<WalletAmountResponse> get walletAmountResponseStream =>
      walletAmount.stream;
  WalletHistoryResponse? walletTransactionListResponse;
  WalletAmountResponse? walletAmountResponse;

  @override
  void dispose() {
    if (!walletTransactionList.isClosed) walletTransactionList.close();
    super.dispose();
  }

  void getWalletDetails(Map? data, Function(WalletHistoryResponse) onSuccess) {
    showLoadingDialog();
    apiWalletHistory(data, (response) {
      hideLoadingDialog();
      walletTransactionListResponse = response;
      if (response.walletHistories!.isEmpty == true) {
        hideLoadingDialog();
        // showMessageBar("No wallet history available");
        print("Akshay:: " + response.walletHistories.toString());
        walletTransactionList.add(walletTransactionListResponse!);
        onSuccess.call(walletTransactionListResponse!);
      } else {
        walletTransactionList.add(walletTransactionListResponse!);
        onSuccess.call(walletTransactionListResponse!);
      }
    }, (error) {
      hideLoadingDialog();
      //showMessageBar("No data Available");
    });
  }

  void getUserWalletAmount(
      Map? data, Function(WalletAmountResponse) onSuccess) {
    showLoadingDialog();
    apiWalletAmount(data, (response) {
      hideLoadingDialog();
      walletAmountResponse = response; // Assign the response directly
      walletAmount.add(walletAmountResponse!);
      onSuccess.call(walletAmountResponse!);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }
}
