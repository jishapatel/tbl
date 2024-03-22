import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/network/error/net_exception.dart';
import '../../base/remote/model/signin_response.dart';
import '../../base/remote/repository/auth_repository.dart';

class SignInScreenBloc extends BasePageBloc {
  SignInScreenBloc() {}

  void doLogin(Map? data, Function(SignInResponse) onSuccess,
      Function(dynamic) onError) {
    showLoadingDialog();
    apiSignIn(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
      onError(error as NetWorkException);
    });
  }
}
