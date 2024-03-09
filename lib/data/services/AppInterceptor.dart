import 'package:dio/dio.dart';
import 'package:lets_chatapp/data/Model/authModel/refresh_token.dart';
import 'package:lets_chatapp/data/services/remote_Source/api_service.dart';
import 'package:lets_chatapp/getit_injector.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../core/shared_preferences/SharedPreferenceHelper.dart';

class AppInterceptor extends Interceptor {
  final _prefs = locator.get<SharedPreferenceHelper>();
  RetrofitClient retrofitClient = RetrofitClient(Dio());

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Content-Type"] = "application/json";

    String? token = _prefs.getValues("token");
    if (token != null) {
      /// Check if token is expired
      bool isTokenExpired = _isTokenExpired(token);
      if (isTokenExpired) {
        print('Inside ifTokenExpired');
        try {
          /// Call refresh token API to get new access token
          String newToken = await _refreshToken();
          _prefs.setValues(key: 'token', value: newToken);
          options.headers["Authorization"] = "Bearer $newToken";
        } catch (e) {
          // Handle token refresh error
          print("Token refresh failed: $e");
        }
      } else {
        /// Token is still valid, use it for the request
         print('Inside else part of TokenExpired');
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    // options.headers["Authorization"] = "Bearer ${_prefs.getValues("token")}";
    // options.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImsxQGdtYWlsLmNvbSIsInVzZXJJRCI6IjY1ZTg1NTgzYTBjZWMxZTE3NzM4MzMxMiIsImlhdCI6MTcwOTcyNjE1NCwiZXhwIjoxNzA5ODEyNTU0fQ.FkWyTA45qRYwo8tXxMTaA2gAzUgSRizcopwkQP7lDw8";
    super.onRequest(options, handler);
  }

  bool _isTokenExpired(String token) {
    print('inside _isTokenExpired');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    int expiryDateInSeconds = decodedToken['exp'];
    DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryDateInSeconds * 1000);

    print("boolen ${DateTime.now().isAfter(expiryDate)}");
    return DateTime.now().isAfter(expiryDate);
  }

  Future<String> _refreshToken() async {
    print('inside refreshtoken');

    String? refreshToken = _prefs.getValues("refreshToken");
    final response = await retrofitClient.refreshToken(
      RefreshTokenRequest(
        refreshToken: refreshToken!,
      ),
    );
    print("inside _Refresh print response ${response.data['accessToken']}");
    return response.data['accessToken'];
  }
}
