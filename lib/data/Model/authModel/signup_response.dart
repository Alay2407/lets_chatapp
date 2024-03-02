
import 'package:json_annotation/json_annotation.dart';
import 'package:lets_chatapp/data/Model/authModel/BaseResponse.dart';

import 'data.dart';

part 'signup_response.g.dart';
@JsonSerializable()
class SignupResponse extends BaseResponse {
  Data? data;

  SignupResponse({ this.data});


  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
