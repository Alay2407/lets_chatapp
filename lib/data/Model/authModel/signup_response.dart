
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'signup_response.g.dart';
@JsonSerializable()
class SignupResponse {
  String? msg;
  Data? data;
  String? accessToken;
  String? refreshToken;

  SignupResponse({this.msg, this.data, this.accessToken, this.refreshToken});


  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
