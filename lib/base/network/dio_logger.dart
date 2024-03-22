import 'package:dio/dio.dart';
import 'dart:math' as math;

import 'base/pretty_logger.dart';

const int initialTab = 1;
const String tabStep = '    ';
bool compact = true;

final dioLoggerInterceptor = InterceptorsWrapper(
    onRequest: (RequestOptions options, handler) {
      _printRequestHeader(options);

      final requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(options.headers);

      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout;
      requestHeaders['receiveTimeout'] = options.receiveTimeout;
      _printMapAsTable(requestHeaders, header: 'Headers');

      _printMapAsTable(options.extra, header: 'Extras');

      _printMapAsTable(options.queryParameters, header: 'Query Parameters');

      if (options.method != 'GET') {
        final dynamic data = options.data;
        if (data != null) {
          if (data is Map) _printMapAsTable(
              options.data as Map?, header: 'Body');
          if (data is FormData) {
            final formDataMap = <String, dynamic>{}..addEntries(
                data.fields)..addEntries(data.files);
            _printMapAsTable(
                formDataMap, header: 'Form data | ${data.boundary}');
          } else {
            _printBlock(data.toString());
          }
        }
      }

      handler.next(options); //continue

    }, onResponse: (Response response, handler) async {
  //_printResponse(response);
  PLog.success(
      "├------------------------------------------------------------------------------");
  PLog.success("Response code ${response.statusCode}");
  PLog.success("Response ${response.data.toString()}");
  PLog.success(
      "└------------------------------------------------------------------------------");
  handler.next(response);
  // return response; // continue
}, onError: (DioError error, handler) async {
  PLog.error("${error.error}: ${error.response?.toString()}");
  PLog.error(
      "└------------------------------------------------------------------------------");
  handler.next(error); //continue
});

int maxWidth = 200;

void _printMapAsTable(Map? map, {String? header}) {
  if (map == null || map.isEmpty) return;
  PLog.cyan('╔ $header ');
  map.forEach(
          (dynamic key, dynamic value) => _printKV(key.toString(), value));
  PLog.cyan('╚');
}

void _printKV(String? key, Object? v) {
  final pre = '╟ $key: ';
  final msg = v.toString();

  if (pre.length + msg.length > maxWidth) {
    PLog.cyan(pre);
    _printBlock(msg);
  } else {
    PLog.cyan('$pre$msg');
  }
}

void _printBlock(String msg) {
  final lines = (msg.length / maxWidth).ceil();
  for (var i = 0; i < lines; ++i) {
    PLog.cyan((i >= 0 ? '║ ' : '') +
        msg.substring(i * maxWidth,
            math.min<int>(i * maxWidth + maxWidth, msg.length))
    );
  }
}

void _printRequestHeader(RequestOptions options) {
  final uri = options.uri;
  final method = options.method;
  _printBoxed(header: 'Request ║ $method ', text: uri.toString());
}

void _printLine([String pre = '', String suf = '╝']) =>
    PLog.cyan('$pre${'═' * maxWidth}$suf');

void _printBoxed({String? header, String? text}) {
  PLog.cyan('');
  PLog.cyan('╔╣ $header');
  PLog.cyan('║  $text');
  _printLine('╚');
}
