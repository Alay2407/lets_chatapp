import 'package:lets_chatapp/data/Model/user/searchUser/searchUserDataModel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'searchUserModel.g.dart';
@JsonSerializable()
class SearchUserModel {
  List<SearchUserData>? data;
  int? totalCount;
  int? totalPages;

  SearchUserModel({this.data, this.totalCount, this.totalPages});


  factory SearchUserModel.fromJson(Map<String, dynamic> json) =>
      _$SearchUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserModelToJson(this);
}
