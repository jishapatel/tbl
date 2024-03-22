import 'dart:convert';

import '../env/environment.dart';
import '../src_api.dart';
import '../utils/shared_pref_utils.dart';

Future<T?> get<T>(String url,
    {params, bool isAuth = true, Options? options, cancelToken}) async {
  options = await authOptions(url, isAuth, options);
  return NetManager.getInstance()
      ?.get<T>(url, params: params, options: options, token: cancelToken);
}

Future<T?> post<T>(String url,
    {params, bool isAuth = true, Options? options, cancelToken}) async {
  options = await authOptions(url, isAuth, options);
  return NetManager.getInstance()
      ?.post<T>(url, params: params, options: options, token: cancelToken);
}

Future<T?> delete<T>(String url,
    {params, bool isAuth = true, Options? options, cancelToken}) async {
  options = await authOptions(url, isAuth, options);
  return NetManager.getInstance()
      ?.delete<T>(url, params: params, options: options, token: cancelToken);
}

Future<T?> put<T>(String url,
    {params, bool isAuth = true, Options? options, cancelToken}) async {
  options = await authOptions(url, isAuth, options);
  return NetManager.getInstance()
      ?.put<T>(url, params: params, options: options, token: cancelToken);
}

Future<Options?> authOptions(String url, bool isAuth, Options? options) async {
  if (isAuth) {
    String? token = "";
    if (url.contains("getToken")) {
      token = getBasicToken();
    } else {
      token = getBearerToken();
    }
    if (options != null) {
      print(getBearerToken());
      options.headers?["X-Authentication-Token"] = getBearerToken();
    } else {
      print(getBearerToken());
      options = Options(
        headers: {'X-Authentication-Token': getBearerToken()},
      );
    }
  }
  return options;
}

class NetManager extends DioManager {
  NetManager._();

  static NetManager? _instance;

  static NetManager? getInstance() {
    _instance ??= NetManager._();
    return _instance;
  }

  @override
  T decode<T>(response) => response;

  @override
  String getBaseUrl() {
    //return "${Environment().config?.apiHost}";
    return "https://api.thebeerlibrary.in/";
  }

  @override
  bool isSuccess(Response? response) {
    return response?.statusCode == 200;
    Map<String, dynamic> data = jsonDecode(response!.data.toString());
    if (data.containsKey("success")) {
      return data["success"] == true && response.statusCode == 200;
    } else {
      return true;
    }
  }

  @override
  bool isShowLog() => Environment().config?.httpLogs ?? false;

  @override
  void logout() {
    onLogout();
  }
}
