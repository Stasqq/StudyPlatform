// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Course _$$_CourseFromJson(Map<String, dynamic> json) => _$_Course(
      json['id'] as String,
      json['ownerUid'] as String,
      json['ownerName'] as String,
      json['name'] as String,
      json['description'] as String,
      json['public'] as bool,
    );

Map<String, dynamic> _$$_CourseToJson(_$_Course instance) => <String, dynamic>{
      'id': instance.id,
      'ownerUid': instance.ownerUid,
      'ownerName': instance.ownerName,
      'name': instance.name,
      'description': instance.description,
      'public': instance.public,
    };
