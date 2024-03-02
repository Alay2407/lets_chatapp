
import 'package:dio/dio.dart';
import 'package:lets_chatapp/getit_injector.dart';

import '../../core/shared_preferences/SharedPreferenceHelper.dart';
class AppInterceptor extends Interceptor {

  final _prefs = locator.get<SharedPreferenceHelper>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Content-Type"] = "application/json";
    options.headers["Authorization"] = "Bearer ${_prefs.getValues("token")}";
    super.onRequest(options, handler);
  }
}