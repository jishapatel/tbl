import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc/base_bloc.dart';
import '../../../base/remote/model/common_response.dart';
import '../../../base/remote/model/profile_response.dart';
import '../../../base/remote/model/save_detail_response.dart';
import '../../../base/remote/repository/auth_repository.dart';

class ProfileScreenBloc extends BasePageBloc {

  late BehaviorSubject<UserDetails?> getUserData;

  get getUserDataStream => getUserData.stream;


  ProfileScreenBloc() {
    getUserData = BehaviorSubject<UserDetails?>.seeded(null);
  }

  void getUserDetails(Function(UserDetails) onSuccess) {
    showLoadingDialog();
    apiGetUserDetails((response) {
      hideLoadingDialog();
      onSuccess.call(response);
      //showMessageBar("profile");
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }

  void deActivateAccount(Function(CommonResponse) onSuccess) {
    showLoadingDialog();
    apiDeActivateAccount((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }

  void deleteAccount(Function(CommonResponse) onSuccess) {
    showLoadingDialog();
    apiDeleteAccount((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }

  void saveUserDetails(Map? data, Function(SaveUserDetail) onSuccess) {
    showLoadingDialog();
    apiSaveUserDetails(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }


  Future<void> doUploadProfile(XFile file, Function(SaveUserDetail) onSuccess) async {
    //  File dataFile = File(file.path);
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      'profile':{
        'profile_image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),}
    });
    print(data);
    showLoadingDialog();
    apiSaveUserDetails(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }

  @override
  void dispose() {
    if (!getUserData.isClosed) getUserData.close();
    super.dispose();
  }
}
