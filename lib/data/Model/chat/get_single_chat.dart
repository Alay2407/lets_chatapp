import 'get_single_chat_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_single_chat.g.dart';
@JsonSerializable()
class GetSingleChat {
  String? msg;
  List<GetSingleChatData>? data;
  int? totalCount;
  int? totalPages;

  GetSingleChat ({this.msg, this.data, this.totalCount, this.totalPages});


  factory GetSingleChat.fromJson(Map<String, dynamic> json) =>
      _$GetSingleChatFromJson(json);

  Map<String, dynamic> toJson() => _$GetSingleChatToJson(this);
}