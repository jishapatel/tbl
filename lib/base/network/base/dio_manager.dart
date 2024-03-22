import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../utils/common_utils.dart';
import '../constants/net_constants.dart';
import '../dio_logger.dart';
import '../error/net_exception.dart';
import 'abstract_dio_manager.dart';

/// The dio network request management class implements most of the common logic. The parts that need to be customized according to the project requirements should be implemented in the subclass, and the subclass should be a singleton
abstract class DioManager extends AbstractDioManager {
  ///Unified configuration, used to add a unified header, please fill in the request for a single add request configuration, a single configuration only affects a single request, and does not affect the unified configuration
  @override
  BaseOptions configBaseOptions() {
    return BaseOptions(
        connectTimeout: HttpCode.TIME_OUT,
        receiveTimeout: HttpCode.TIME_OUT,
        baseUrl: getBaseUrl(),
        //headers: { 'X-Authentication-Token': 'fd084fb4fb5ee4b23ff9d7f4156b7ae327e0e3cf2f571b00c5fb53c9aec3bd29', },
        validateStatus: (status) {
          // Do not use http status code to judge the status, use AdapterInterceptor to handle (applicable to standard REST style)
          return true;
        },
        responseType: ResponseType.plain);
  }

  @override
  void configDio(Dio? dio) {
    if (isShowLog()) {
      dio?.interceptors.add(dioLoggerInterceptor);
    }
  }

  ///Business logic error mapping, currently not doing translation work, the default error message returned by the server is returned
  @override
  NetWorkException getBusinessErrorResult(int code, String error) =>
      NetWorkException(code, error);

  /// HTTP layer network request error translation
  @override
  NetWorkException getHttpErrorResult(DioError e) {
    Response? errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = Response(
          statusCode: HttpCode.UNKNOWN_NET_ERROR,
          statusMessage: "Unknown error",
          requestOptions: e.requestOptions);
    }
    if (e.type == DioErrorType.connectTimeout) {
      errorResponse?.statusMessage = string("error_server_connection_timeout");
      errorResponse?.statusCode = HttpCode.CONNECT_TIMEOUT;
    } else if (e.type == DioErrorType.sendTimeout) {
      errorResponse?.statusMessage = "Request timed out";
      errorResponse?.statusCode = HttpCode.SEND_TIMEOUT;
    } else if (e.type == DioErrorType.receiveTimeout) {
      errorResponse?.statusMessage = "Response timeout";
      errorResponse?.statusCode = HttpCode.RECEIVE_TIMEOUT;
    } else if (e.type == DioErrorType.cancel) {
      errorResponse?.statusMessage = "Request to cancel";
      errorResponse?.statusCode = HttpCode.REQUEST_CANCEL;
    } else if (e.type == DioErrorType.other) {
      dynamic error = e.error;
      if (error is SocketException) {
        errorResponse?.statusCode = HttpCode.NETWORK_ERROR;
        errorResponse?.statusMessage = string("error_network_connection");
      } else if (error is HttpException) {
        errorResponse?.statusCode = HttpCode.UNKNOWN_NET_ERROR;
        errorResponse?.statusMessage = string("error_server_connection");
      } else {
        errorResponse?.statusCode = HttpCode.UNKNOWN_NET_ERROR;
        errorResponse?.statusMessage = string("error_server_connection");
      }
    } else if (e.type == DioErrorType.response) {
      switch (e.response?.statusCode) {
        case 400:
          errorResponse?.statusMessage = "Request syntax error";
          break;
        case 401:
          logout();
          errorResponse?.statusMessage = "Authentication failed";
          break;
        case 403:
          errorResponse?.statusMessage = "Server refused to execute";
          break;
        case 404:
          errorResponse?.statusMessage = string("error_server_connection");
          break;
        case 405:
          errorResponse?.statusMessage = "The request method is forbidden";
          break;
        case 500:
          errorResponse?.statusMessage = string("error_internal_server");
          break;
        case 502:
          errorResponse?.statusMessage = "Invalid request";
          break;
        case 503:
          errorResponse?.statusMessage = "The server is down";
          break;
        case 505:
          errorResponse?.statusMessage =
          "HTTP protocol request is not supported";
          break;
        default:
          errorResponse?.statusMessage = string("error_unknown");
          break;
      }
    } else {
      errorResponse?.statusMessage = string("error_unknown");
      errorResponse?.statusCode = HttpCode.UNKNOWN_NET_ERROR;
    }
    return new NetWorkException(
        errorResponse?.statusCode, errorResponse?.statusMessage);
  }

  ///Determine whether the network request is successful
  @override
  bool isSuccess(Response? response) {
    Map<String, dynamic> data = jsonDecode(response!.data.toString());
    if (data.containsKey("success")) {
      return data["success"] == true && response.statusCode == 200;
    } else {
      return true;
    }
  }

  ///Whether to display the log log
  bool isShowLog() => false;

  ///Set baseURl
  String getBaseUrl();
}
