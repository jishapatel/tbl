import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/remote/model/ResendOTPResponse.dart';
import '../../base/remote/model/otp_verification_response.dart';
import '../../base/remote/repository/auth_repository.dart';

class OtpScreenBloc extends BasePageBloc {
  //String? key_mobileNumber;

  void doOtpVerification(
      Map? data, Function(OtpVerificationResponse) onSuccess) {
    showLoadingDialog();
    apiOtpVerification(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

  void resendOtp(
      Map? data, Function(ResendOtpResponse) onSuccess) {
    showLoadingDialog();
    apiResendOtp(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

}
