import 'package:lets_chatapp/data/Model/chat/getAll_chat.dart';
import 'package:lets_chatapp/domain/repositories/getAllChatRepository.dart';

import '../services/AppInterceptor.dart';
import '../services/remote_Source/api_service.dart';
import 'package:dio/dio.dart';

class GetAllChatRepositoryImpl extends GetAllChatRepository {
  final RetrofitClient _retrofitclient = RetrofitClient(Dio()..interceptors.add(AppInterceptor()));

  // final sharedPrefLocator = locator.get<SharedPreferenceHelper>();

  @override
  Future<GetAllChat> getAllChat() async {
    final response = await _retrofitclient.getAllChat();
    if (response.response.statusCode == 200) {
      print("change pass status code is sdf ==> ${response.response.statusCode}");
    }
    return response.data;
  }
}
