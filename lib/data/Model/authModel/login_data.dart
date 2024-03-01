import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';
@JsonSerializable()
class LoginData {
  String? sId;
  String? name;
  String? email;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? description;
  String? profilePic;

  LoginData(
      {this.sId,
        this.name,
        this.email,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.description,
        this.profilePic});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

}