import 'package:json_annotation/json_annotation.dart';
part 'get_single_chat_data.g.dart';
@JsonSerializable()

class GetSingleChatData {
  String? id;
  String? sender_id;
  String? receiver_id;
  String? message;
  String? createdAt;

  GetSingleChatData(
      {this.id, this.sender_id, this.receiver_id, this.message, this.createdAt});


  factory GetSingleChatData.fromJson(Map<String, dynamic> json) =>
      _$GetSingleChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetSingleChatDataToJson(this);
}