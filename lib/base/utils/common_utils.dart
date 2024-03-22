import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../src_constants.dart';

typedef OnItemTap<T> = void Function(BuildContext context, T? data, int? index);

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

String string(String key, [dynamic args]) {
  return globalContext.getString(key, args);
}

Future<String?> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return (bytes != null ? base64Encode(bytes) : null);
}

Uint8List getUint8List(String path) {
  File file = File(path);
  return file.readAsBytesSync();
}

String getBase64FromUint8List(Uint8List bytes) {
  return base64Encode(bytes);
}

String getBase64File(String path) {
  Uint8List bytes = getUint8List(path);
  return getBase64FromUint8List(bytes);
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}