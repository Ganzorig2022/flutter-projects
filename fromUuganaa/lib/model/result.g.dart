// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    success: json['success'],
    error: json['error'],
    isSuccess: json['is_success'] as bool,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'is_success': instance.isSuccess,
    };
