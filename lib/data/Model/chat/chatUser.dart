import 'package:json_annotation/json_annotation.dart';
part 'chatUser.g.dart';
@JsonSerializable()
class User {
  String? userID;

  User({this.userID});
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
