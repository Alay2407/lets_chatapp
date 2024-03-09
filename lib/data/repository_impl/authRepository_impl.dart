import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/domain/repositories/auth_repository.dart';

import '../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../getit_injector.dart';
import '../Model/authModel/changepass_request.dart';
import '../Model/authModel/login_request.dart';
import '../Model/authModel/signup_request.dart';
import '../services/AppInterceptor.dart';
import '../services/remote_Source/api_service.dart';
import 'package:dio/dio.dart';

class AuthRepositoryimpl extends AuthRepository {
  final RetrofitClient _retrofitclient = RetrofitClient(Dio()..interceptors.add(AppInterceptor()));

  final sharedPrefLocator = locator.get<SharedPreferenceHelper>();

  @override
  Future<LoginData> changePassword(String currentPassword, String newPassword) async {
    // final RetrofitClient _retrofitClient = locator<RetrofitClient>();

    // final sharedPrefLocator = locator.get<SharedPreferenceHelper>().prefs.getInt('token');
    final response = await _retrofitclient.changePassword(
      ChangepassRequest(currentPassword, newPassword),
    );

    if (response.response.statusCode == 200) {
      print("change pass status code is sdf ==> ${response.response.statusCode}");
      print("Changepass data is sdf ==> ${response.data.data!.name}");
      print("Changepass data is sdf ==> ${response.data.msg}");
      print("Changepass data is sdf ==> ${response.response.statusMessage}");
      return response.data.data!;
      // return response.response.data;
    }
    return response.data.data!;
  }

  @override
  Future<LoginData> login(String email, String password) async {
    final response = await _retrofitclient.login(LoginRequest(email, password));

    if (response.response.statusCode == 200) {
      await sharedPrefLocator.setValues(
        key: 'token',
        value: response.data.accessToken.toString(),
      );

      await sharedPrefLocator.setValues(
        key: "refreshToken",
        value: response.data.refreshToken.toString(),
      );
      print("status code is sdf ==> ${response.response.statusCode}");
      print("Response statusMessagfe is ==> ${response.response.statusMessage}");
      print("Data Status Message is ==> ${response.data.msg}");
      print("data is sdf ==> ${response.data.data!.name}");
      print("data is sdf ==> ${response.response.statusMessage}");
      return response.data.data!;
      // return response.response.data;
    }
    // else if (response.response.statusCode == 401) {
    //   // Unauthorized access
    //
    //   print("Unauthorized access. Status code: ${response.response.statusCode}");
    //   // throw AppException('Unauthorized access: ${response.data.msg}');
    //   return response.data.data!;
    // } else {
    //   // Other error cases
    //   print("Login failed. Status code: ${response.response.statusCode}");
    //   // throw AppException('Login failed: ${response.response.statusCode}');
    //   return response.data.data!;
    // }
    // throw AppException('Somethinf wjw');
    return response.data.data!;
  }

  @override
  Future<SignupResponse> signUp(String name, String email, String password, String confirmPassword) async {
    print('called signup');
    // print('retrofitClient==> $_retrofitClient');
    SignupResponse response = await _retrofitclient.signup(SignupRequest(name, email, password, confirmPassword));

    print('Response is');
    if (response.data != null) {
      await sharedPrefLocator.setValues(key: 'token', value: response.accessToken.toString());
      await sharedPrefLocator.setValues(key: "refreshToken", value: response.refreshToken.toString());
      return response;
    }
    return response;
    // throw AppException("Something Wrong");
  }
}
