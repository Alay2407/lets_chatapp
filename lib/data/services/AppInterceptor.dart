
import 'package:dio/dio.dart';
class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers["Content-Type"] = "application/json";
    // options.headers["Authorization"] = "Bearer ${_prefs.getValues("token")}";
    super.onRequest(options, handler);
  }
}