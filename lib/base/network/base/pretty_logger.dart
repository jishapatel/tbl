import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// deprecated
///  use [PLog] instead
/// example:
/// ```dart
/// PLog.info('hello world');
/// ```
///
class Logger {
  // main.dart

  // Blue text
  /// param [msg] is the message to be logged to the console
  /// example:
  /// ```dart
  /// PLog.info('hello world');
  /// ```
  static void info(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  // Green text
  /// param [msg] is the message to be logged to the console
  /// example:
  ///  ```dart
  ///  PLog.success('hello world');
  /// ```
  ///
  static void success(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  // Yellow text
  static void warning(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  // Red text
  static void error(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void black(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void white(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void red(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void green(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void yellow(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void blue(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  static void cyan(String msg) {
    if (kDebugMode) developer.log('$msg');
  }
}

class PLog {
  // main.dart

  // Blue text
  /// param [msg] is the message to be logged to the console
  /// example:
  /// ```dart
  /// PLog.info('hello world');
  /// ```
  ///
  static void info(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  // Green text
  /// param [msg] is the message to be logged to the console
  /// example:
  /// ```dart
  /// PLog.success('hello world');
  /// ```
  ///
  static void success(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  // Yellow text
  /// param [msg] is the message to be logged to the console
  static void warning(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  /// Red text
  static void error(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void black(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void white(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void red(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void green(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void yellow(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void blue(String msg) {
    if (kDebugMode) developer.log('$msg');
  }

  /// param [msg] is the message to be logged to the console
  static void cyan(String msg) {
    if (kDebugMode) developer.log('$msg');
  }
}