import 'package:lets_chatapp/data/Model/message/send_msg_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'send_message.g.dart';
@JsonSerializable()
class SendMessage {
  String? msg;
  SendMsgData? sendMsgData;

  SendMessage({this.msg, this.sendMsgData});
  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageToJson(this);
}