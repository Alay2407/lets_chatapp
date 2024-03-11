import 'package:lets_chatapp/data/Model/message/send_message_body.dart';

import '../Model/message/send_message.dart';
import '../services/AppInterceptor.dart';
import '../services/remote_Source/api_service.dart';
import 'package:dio/dio.dart';

class SendMsgRepositoryImpl {
  final RetrofitClient _retrofitclient = RetrofitClient(Dio()..interceptors.add(AppInterceptor()));

  // final sharedPrefLocator = locator.get<SharedPreferenceHelper>();

  @override
  Future<SendMessage> sendMessage(String receiverId,SendMessageBody sendMessageBody) async {
    final response = await _retrofitclient.sendMessage(receiverId, sendMessageBody);
    if (response.response.statusCode == 200) {
      print("change pass status code is sdf ==> ${response.response.statusCode}");
    }
    return response.data;
  }
}
