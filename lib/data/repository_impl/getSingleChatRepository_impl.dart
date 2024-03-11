// import 'package:lets_chatapp/data/Model/chat/get_single_chat.dart';
// import '../services/AppInterceptor.dart';
// import '../services/remote_Source/api_service.dart';
// import 'package:dio/dio.dart';
// class GetSingleChatRepositoryImpl {
//   final RetrofitClient _retrofitclient = RetrofitClient(Dio()..interceptors.add(AppInterceptor()));
//
//   // final sharedPrefLocator = locator.get<SharedPreferenceHelper>();
//
//   @override
//   Future<GetSingleChat> sendMessage(String receiverId) async {
//     final response = await _retrofitclient.getSingleChat(receiverId);
//     if (response.response.statusCode == 200) {
//       print("Get single chat ==> ${response.response.statusCode}");
//     }
//     return response.data;
//   }
// }