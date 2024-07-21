import 'package:json_annotation/json_annotation.dart';
part 'result.g.dart';

@JsonSerializable(includeIfNull: true)
class Result {
  @JsonKey(name: 'success')
  dynamic success;

  @JsonKey(name: 'error')
  dynamic error;

  @JsonKey(name: 'is_success')
  bool isSuccess;

  Result({
    this.success = const {},
    this.error,
    this.isSuccess = false,
  });
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
