import 'dart:convert';

import 'package:dio/dio.dart';

import '../constants/net_constants.dart';
import '../error/net_exception.dart';

/// Network request management abstraction layer\
/// Responsible for executing the general logic of network requests
/// The different configurations of different projects are handed over to the upper layer to achieve
abstract class AbstractDioManager {
  //Dio? dio;

  Dio? getDio() {
    Dio? dio = Dio(configBaseOptions());
    configDio(dio);
    return dio;
  }

  AbstractDioManager() {
    /*dio = Dio(configBaseOptions());
    //dio?.options.headers['content-Type'] = 'application/json';
    configDio();*/
  }

  ///get request
  Future<T> get<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.GET,
      params: params,
      options: options,
      cancelToken: token,
      decode: this.decode,
    );
  }

  ///post request
  Future<T> post<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.POST,
      params: params,
      options: options,
      cancelToken: token,
      decode: this.decode,
    );
  }

  Future<T> delete<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.DELETE,
      params: params,
      options: options,
      cancelToken: token,
      decode: this.decode,
    );
  }

  Future<T> put<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.PUT,
      params: params,
      options: options,
      cancelToken: token,
      decode: this.decode,
    );
  }

  Future<T> patch<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.PATCH,
      params: params,
      options: options,
      cancelToken: token,
      decode: this.decode,
    );
  }

  ///R is the return type, T is the data type
  Future<R> requestHttp<R>(
    String url,
    Method method, {
    params,
    options,
    cancelToken,
    required R decode(dynamic json),
  }) async {
    options = options ??
        Options(
          headers: {'Content-Type': 'application/json'},
        );
    Response? response;
    try {
      if (method == Method.GET) {
        response = await getDio()?.get(url,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      } else if (method == Method.POST) {
        response = await getDio()?.post(url,
            data: params, options: options, cancelToken: cancelToken);
      } else if (method == Method.DELETE) {
        response = await getDio()?.delete(url,
            data: params, options: options, cancelToken: cancelToken);
      } else if (method == Method.PUT) {
        response = await getDio()?.put(url,
            data: params, options: options, cancelToken: cancelToken);
      } else if (method == Method.PATCH) {
        response = await getDio()?.patch(url,
            data: params, options: options, cancelToken: cancelToken);
      }
    } on DioError catch (error) {
      throw getHttpErrorResult(error);
    } catch (error) {
      //debugPrint("---------- net error $error");
    }
    //Whether there is an error in the priority parsing request
    if (!isSuccess(response)) {
      if (response?.statusCode == 401) {
        logout();
        throw getBusinessErrorResult(getCode(response), getMessage(response));
      } else if (response?.statusCode == 422) {
        throw getBusinessErrorResult(
            getCode(response), "Phone number has already been taken");
      } else {
        throw getBusinessErrorResult(getCode(response), getMessage(response));
      }
    }
    //Ensure that the request is successful, then instantiate the data
    R data;
    try {
      data = decode(response?.data.toString());
      //data = decode(response?.data['data']);
    } catch (e) {
      throw getBusinessErrorResult(
          HttpCode.PARSE_JSON_ERROR, "json parse error~$e");
    }
    return data;
  }

  ///The upper level realization of the specific analysis logic
  T decode<T>(dynamic response);

  ///Business logic error mapping
  NetWorkException getBusinessErrorResult(int code, String error);

  /// HTTP layer network request error translation
  NetWorkException getHttpErrorResult(DioError e);

  ///Initialize dio parameters
  BaseOptions configBaseOptions();

  ///Judge the success or failure of the business layer's return, report an error after failure, and perform data analysis after success
  bool isSuccess(Response? response);
  // {
  //   if (response == null && response?.data == null) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  ///The default is "code" to get the response code. If the key of the code returned by the server request is different, please rewrite this method
  int getCode(Response? response) {
    Map<String, dynamic> data = jsonDecode(response!.data.toString());
    return data["success"] == true ? 200 : response.statusCode ?? 1212;
  }

  ///The default is "message" to get the response message. If the key of the message returned by the server request is different, please override this method
  String getMessage(Response? response) {
    Map<String, dynamic> data = jsonDecode(response!.data.toString());
    return data["message"];
  }

  ///dio configuration work, add interceptors and other operations
  void configDio(Dio? dio);

  ///Token invalid logout logic
  void logout();
}
