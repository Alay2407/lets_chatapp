import 'package:lets_chatapp/data/Model/authModel/BaseResponse.dart';
import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:json_annotation/json_annotation.dart';


part 'login_response.g.dart';
@JsonSerializable()
class LoginResponse{
  String? msg;
  String? accessToken;
  String? refreshToken;
  LoginData? data;
  LoginResponse({this.data,this.msg,this.accessToken,this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}