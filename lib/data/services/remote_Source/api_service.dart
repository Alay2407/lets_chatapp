import 'package:lets_chatapp/data/Model/authModel/changepass_request.dart';
import 'package:lets_chatapp/data/Model/authModel/login_request.dart';
import 'package:lets_chatapp/data/Model/authModel/login_response.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../Model/authModel/signup_request.dart';
import '../../Model/chat/getAll_chat.dart';

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
}
