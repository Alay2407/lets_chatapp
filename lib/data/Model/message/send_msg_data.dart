
import 'package:json_annotation/json_annotation.dart';
part 'send_msg_data.g.dart';
@JsonSerializable()
class SendMsgData {
  String? chatId;
  String? messageId;
  String? senderId;
  String? receiverId;
  String? message;

  SendMsgData({this.chatId,
    this.messageId,
    this.senderId,
    this.receiverId,
    this.message});
  factory SendMsgData.fromJson(Map<String, dynamic> json) =>
      _$SendMsgDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendMsgDataToJson(this);

}