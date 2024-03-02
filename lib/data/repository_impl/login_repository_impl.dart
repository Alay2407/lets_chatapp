import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/data/Model/authModel/login_request.dart';
import 'package:lets_chatapp/data/services/AppException.dart';
import 'package:lets_chatapp/domain/repositories/login_repository.dart';
import '../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../getit_injector.dart';
import '../services/remote_Source/api_service.dart';

class LoginRepositoryImpl extends LoginRepository {
  final RetrofitClient _retrofitClient = locator<RetrofitClient>();

  final sharedPrefLocator = locator.get<SharedPreferenceHelper>();

  @override
  Future<LoginData> login(String email, String password) async {
    final response = await _retrofitClient.login(LoginRequest(email, password));

    if (response.response.statusCode == 200) {
      await sharedPrefLocator.setValues(
        key: 'token',
        value: response.data.accessToken.toString(),
      );

      print("status code is sdf ==> ${response.response.statusCode}");
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
}
