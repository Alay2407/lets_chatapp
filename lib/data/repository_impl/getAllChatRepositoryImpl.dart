import 'package:lets_chatapp/data/Model/chat/getAll_chat.dart';
import 'package:lets_chatapp/data/Model/chat/get_single_chat_data.dart';
import 'package:lets_chatapp/domain/repositories/getAllChatRepository.dart';

import '../Model/chat/get_single_chat.dart';
import '../Model/user/getSingleUser/getSingleUserModel.dart';
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


  @override
  Future<GetSingleChat> getSingleChat(String chatID) async {
    final response = await _retrofitclient.getSingleChat(chatID);
    if (response.response.statusCode == 200) {
      print("Get single chat status code is  ===> ${response.response.statusCode}");
    }
    return response.data;
  }

  @override
  Future<GetSingleUser> getSingleUser(String emailID) async {
    final response = await _retrofitclient.getSingleUser(emailID);


    if (response.response.statusCode == 200) {
      print("Get single User status code is  ===> ${response.response.statusCode}");
      print("Get single User id is  ===> ${response.data.data!.id}");
      print("Get single User name is  ===> ${response.data.data!.name}");
      print("Get single User email is  ===> ${response.data.data!.email}");
    }
    return response.data;
  }
}
