import 'package:json_annotation/json_annotation.dart';


part 'refresh_token.g.dart';
@JsonSerializable()
class RefreshTokenRequest{
  final String refreshToken;
  RefreshTokenRequest({required this.refreshToken});


  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}