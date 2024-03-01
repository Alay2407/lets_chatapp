import 'package:json_annotation/json_annotation.dart';



part 'data.g.dart';
@JsonSerializable()
class Data {
  String? name;
  String? email;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Data({this.name,
    this.email,
    this.isDeleted,
    this.sId,
    this.createdAt,
    this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}