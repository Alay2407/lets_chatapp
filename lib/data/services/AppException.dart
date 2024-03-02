import 'dart:core';

class AppException implements Exception {
  final String message;

  AppException(this.message);

  // @override
  // String toString() => message;

  @override
  String toString() {
    return 'AppException: $message';
  }
}