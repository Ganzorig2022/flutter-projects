// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reference _$ReferenceFromJson(Map<String, dynamic> json) {
  return Reference(
    id: json['id'] as String?,
    name: json['name'] as String?,
    img: json['img'] as String?,
  );
}

Map<String, dynamic> _$ReferenceToJson(Reference instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
    };
