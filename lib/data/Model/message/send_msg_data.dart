
import 'package:json_annotation/json_annotation.dart';
part 'send_msg_data.g.dart';
@JsonSerializable()
class SendMsgData {
  String? chat_id;
  String? message_id;
  String? sender_id;
  String? receiver_id;
  String? message;

  SendMsgData({this.chat_id,
    this.message_id,
    this.sender_id,
    this.receiver_id,
    this.message});
  factory SendMsgData.fromJson(Map<String, dynamic> json) =>
      _$SendMsgDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendMsgDataToJson(this);

}