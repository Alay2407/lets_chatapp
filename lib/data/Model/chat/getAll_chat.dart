import 'package:lets_chatapp/data/Model/chat/chatData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getAll_chat.g.dart';
@JsonSerializable()
class GetAllChat {
  String? msg;
  ChatData? data;

  GetAllChat({this.msg, this.data});

  factory GetAllChat.fromJson(Map<String, dynamic> json) =>
      _$GetAllChatFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllChatToJson(this);

}