
import 'package:json_annotation/json_annotation.dart';

part 'getSingleUserData.g.dart';
@JsonSerializable()

class GetSingleUserData {
  String? id;
  String? name;
  String? email;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;


  GetSingleUserData(
      {this.id,
        this.name,
        this.email,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
      });



  factory GetSingleUserData.fromJson(Map<String, dynamic> json) =>
      _$GetSingleUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetSingleUserDataToJson(this);
}