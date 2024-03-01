import 'package:lets_chatapp/data/Model/authModel/signup_request.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/data/services/remote_Source/api_service.dart';
import 'package:lets_chatapp/domain/repositories/signup_repository.dart';
import 'package:lets_chatapp/getit_injector.dart';

import '../../core/shared_preferences/SharedPreferenceHelper.dart';

class SignupRepositoryImpl extends SignUpRepository {
  final RetrofitClient _retrofitClient = locator<RetrofitClient>();

  // final RetrofitClient _retrofitClient = RetrofitClient(Dio());

  final sharedPrefLocator = locator.get<SharedPreferenceHelper>();

  @override
  Future<SignupResponse> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      print('called signup');
      // print('retrofitClient==> $_retrofitClient');
      SignupResponse response = await _retrofitClient.signup(
        SignupRequest(
          name,
          email,
          password,
          confirmPassword,
        ),
      );
      print(response);
      print('Click');

      if(response.data!=null){
        await sharedPrefLocator.setValues(key: 'token', value: response.accessToken.toString());
      }
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
