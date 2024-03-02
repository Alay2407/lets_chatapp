import 'package:dio/dio.dart';

class ApiResponse<T> {
  int statusCode;
  T? data;
  String? message;

  ApiResponse({required this.statusCode, this.data, this.message});

  factory ApiResponse.fromJson(Response<dynamic> response) {
    return ApiResponse(
      statusCode: response.statusCode ?? 0,
      data: response.data,
      message: response.statusMessage,
    );
  }
}