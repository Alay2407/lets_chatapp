import 'package:lets_chatapp/data/Model/authModel/changepass_request.dart';
import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/domain/repositories/changepass_repository.dart';

import '../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../getit_injector.dart';
import '../services/AppInterceptor.dart';
import '../services/remote_Source/api_service.dart';
import 'package:dio/dio.dart';
class ChangepassRepositoryImpl extends ChangepassRepository {
  // final RetrofitClient _retrofitClient = locator<RetrofitClient>();
  final RetrofitClient _retrofitclient =
  RetrofitClient(Dio()..interceptors.add(AppInterceptor()));
  // final sharedPrefLocator = locator.get<SharedPreferenceHelper>().prefs.getInt('token');

  @override
  Future<LoginData> changePassword(String currentPassword, String newPassword) async {
    // print(sharedPrefLocator);
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
}
