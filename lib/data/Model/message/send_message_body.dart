import 'package:json_annotation/json_annotation.dart';


part 'send_message_body.g.dart';
@JsonSerializable()
class SendMessageBody{

  final String message;


  SendMessageBody(this.message);

  factory SendMessageBody.fromJson(Map<String, dynamic> json) =>
      _$SendMessageBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageBodyToJson(this);
}


