import 'package:json_annotation/json_annotation.dart';

part 'changepass_request.g.dart';
@JsonSerializable()
class ChangepassRequest{
  String? currentPassword;
  String? newPassword;

  ChangepassRequest(this.currentPassword, this.newPassword);


  factory ChangepassRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangepassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangepassRequestToJson(this);
}
