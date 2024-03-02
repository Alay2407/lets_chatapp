// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..msg = json['msg'] as String?
      ..accessToken = json['accessToken'] as String?
      ..refreshToken = json['refreshToken'] as String?;

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'data': instance.data,
    };
