import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:json_annotation/json_annotation.dart';


part 'login_response.g.dart';
@JsonSerializable()
class LoginResponse {
  String? msg;
  LoginData? data;
  String? accessToken;
  String? refreshToken;

  LoginResponse({this.msg, this.data, this.accessToken, this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}