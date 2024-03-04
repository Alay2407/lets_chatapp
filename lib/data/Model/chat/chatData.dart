import 'chat.dart';
import 'chatUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chatData.g.dart';
@JsonSerializable()
class ChatData {
  User? user;
  List<Chats>? chats;
  int? totalCount;
  int? totalPages;

  ChatData({this.user, this.chats, this.totalCount, this.totalPages});

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);

}