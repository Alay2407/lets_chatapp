import 'getSingleUserData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getSingleUserModel.g.dart';
@JsonSerializable()
class GetSingleUser {
  GetSingleUserData? data;

  GetSingleUser({this.data});


  factory GetSingleUser.fromJson(Map<String, dynamic> json) =>
      _$GetSingleUserFromJson(json);

  Map<String, dynamic> toJson() => _$GetSingleUserToJson(this);
}