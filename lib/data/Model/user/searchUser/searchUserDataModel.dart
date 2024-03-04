import 'package:json_annotation/json_annotation.dart';

part 'searchUserDataModel.g.dart';
@JsonSerializable()
class SearchUserData {
  String? id;
  String? name;
  String? email;

  SearchUserData({this.id, this.name, this.email});


  factory SearchUserData.fromJson(Map<String, dynamic> json) =>
      _$SearchUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserDataToJson(this);
}