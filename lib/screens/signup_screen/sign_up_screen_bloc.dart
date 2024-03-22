import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/remote/model/signin_response.dart';
import '../../base/remote/model/verify_user_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:rxdart/src/streams/value_stream.dart';

import '../../base/remote/repository/auth_repository.dart';

class SignUpScreenBloc extends BasePageBloc {
  SignUpScreenBloc() {}

  void doSignUp(Map? data, Function(SignInResponse) onSuccess) {
    showLoadingDialog();
    apiSignUp(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

}
