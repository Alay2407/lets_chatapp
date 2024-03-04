import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';
@JsonSerializable()
class Chats {
  String? chatID;
  String? name;
  String? email;
  String? profilePic;
  String? last_message;
  String? time;
  String? userID;

  Chats(
      {this.chatID,
        this.name,
        this.email,
        this.profilePic,
        this.last_message,
        this.time,
        this.userID});


  factory Chats.fromJson(Map<String, dynamic> json) =>
      _$ChatsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsToJson(this);
}