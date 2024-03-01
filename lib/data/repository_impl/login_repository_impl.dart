import 'dart:io';

import 'package:lets_chatapp/data/Model/authModel/login_request.dart';
import 'package:lets_chatapp/data/Model/authModel/login_response.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/domain/repositories/login_repository.dart';

import '../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../getit_injector.dart';
import '../services/remote_Source/api_service.dart';

class LoginRepositoryImpl extends LoginRepository {
  final RetrofitClient _retrofitClient = locator<RetrofitClient>();

  final sharedPrefLocator = locator.get<SharedPreferenceHelper>();

  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _retrofitClient.login(LoginRequest(email, password));

      if (response.data != null) {
        sharedPrefLocator.setValues(key: 'token', value: response.accessToken.toString());


        print("Name is ${sharedPrefLocator.getValues('name')}");
        print('Inside if satatement');
        return response;
      }
      print('login reposnse is ${response.toJson()}');
      print('Click');

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
