import 'package:rxdart/rxdart.dart';

import '../../../base/baseSingleton.dart';
import '../../../base/bloc/base_bloc.dart';
import '../../../base/remote/model/home_response.dart';
import '../../../base/remote/repository/auth_repository.dart';

class HomeScreenBloc extends BasePageBloc {
  late BehaviorSubject<HomeResponse> home;

  HomeScreenBloc() {
    home = BehaviorSubject<HomeResponse>();
  }

  Stream<HomeResponse> get homeResponseStream => home.stream;

  //HomeResponse? homeResponse;

  @override
  void dispose() {
    home.close();
    super.dispose();
  }

  dynamic doHome(Map? data, Function(HomeResponse) onSuccess) {
    apiHome(data, (response) {
      hideLoadingDialog();
      //MySingleton().homeResponse = response; // Assign the response directly
      //MySingleton().home!.add(MySingleton().homeResponse!);
      home.add(response);
      onSuccess.call(MySingleton().homeResponse!);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }
}
