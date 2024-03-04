import 'package:lets_chatapp/data/Model/user/searchUser/searchUserModel.dart';
import 'package:lets_chatapp/data/services/remote_Source/api_service.dart';
import 'package:lets_chatapp/domain/repositories/searchUserRepository.dart';
import 'package:dio/dio.dart';

import '../services/AppInterceptor.dart';

class SearchUserRepositoryImpl extends SearchUserRepository {
  final RetrofitClient _retrofitclient = RetrofitClient(Dio()..interceptors.add(AppInterceptor()));

  @override
  Future<SearchUserModel> searchUser(String name) async {
    final response = await _retrofitclient.searchUser(name);

    if (response.response.statusCode == 200) {
      print("Search user status code is ==> ${response.response.statusCode}");
      print("Response statusMessagfe is ==> ${response.response.statusMessage}");
      print("Data Status Message is && ==> ${response.data.data![0].name}");
      print("Data email is && ==> ${response.data.data![0].email}");
      print("Search User response message is ==> ${response.response.statusMessage}");
      print("data is sdf ==> ${response.response.statusMessage}");
      return response.data;
    }
    return response.data;
  }
}
