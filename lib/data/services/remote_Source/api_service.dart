import 'package:lets_chatapp/data/Model/authModel/changepass_request.dart';
import 'package:lets_chatapp/data/Model/authModel/login_request.dart';
import 'package:lets_chatapp/data/Model/authModel/login_response.dart';
import 'package:lets_chatapp/data/Model/authModel/refresh_token.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/data/Model/user/searchUser/searchUserModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../Model/authModel/signup_request.dart';
import '../../Model/chat/getAll_chat.dart';
import '../../Model/chat/get_single_chat.dart';
import '../../Model/message/send_message.dart';
import '../../Model/message/send_message_body.dart';
import '../../Model/user/getSingleUser/getSingleUserModel.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://stage-ultro-chat-node.onrender.com")
abstract class RetrofitClient {
  static final RetrofitClient client = RetrofitClient(Dio());

  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @POST("/v1/auth/register")
  Future<SignupResponse> signup(@Body() SignupRequest signupRequest);

  @POST("/v1/auth/login")
  Future<HttpResponse<LoginResponse>> login(@Body() LoginRequest loginRequest);

  @PUT("/v1/user/change-password")
  Future<HttpResponse<LoginResponse>> changePassword(@Body() ChangepassRequest changepassRequest);

  @GET("/v1/chat/all-chats?page=1&limit=10")
  Future<HttpResponse<GetAllChat>> getAllChat();

  @GET("/v1/user/get-by-name/{name}?page=1&limit=20")
  Future<HttpResponse<SearchUserModel>> searchUser(@Path('name') String name);

  @POST("/v1/auth/refresh")
  Future<HttpResponse> refreshToken(@Body() RefreshTokenRequest refreshTokenRequest);


  @POST("/v1/message/{receiverId}")
  Future<HttpResponse<SendMessage>> sendMessage(@Path('receiverId') String receiverId, @Body() SendMessageBody sendMessageBody);

  @GET("/v1/chat/{chatID}?page=1&limit=10")
  Future<HttpResponse<GetSingleChat>> getSingleChat(@Path('chatID') String chatID);



  @GET("/v1/user/get-user/{email}")
  Future<HttpResponse<GetSingleUser>> getSingleUser(@Path('email') String email);

}
