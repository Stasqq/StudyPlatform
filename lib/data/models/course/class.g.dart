// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Class _$$_ClassFromJson(Map json) => _$_Class(
      json['name'] as String,
      json['orderIndex'] as int,
      json['description'] as String,
      json['htmlBodyPath'] as String,
      (json['materials'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ClassToJson(_$_Class instance) => <String, dynamic>{
      'name': instance.name,
      'orderIndex': instance.orderIndex,
      'description': instance.description,
      'htmlBodyPath': instance.htmlBodyPath,
      'materials': instance.materials,
    };
