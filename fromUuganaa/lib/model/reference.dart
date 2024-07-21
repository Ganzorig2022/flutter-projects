import 'package:json_annotation/json_annotation.dart';
part 'reference.g.dart';

@JsonSerializable(includeIfNull: true)
class Reference {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'img')
  String? img;

  Reference({
    this.id,
    this.name,
    this.img,
  });
  factory Reference.fromJson(Map<String, dynamic> json) => _$ReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceToJson(this);
}
