// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Test _$$_TestFromJson(Map json) => _$_Test(
      json['name'] as String,
      json['open'] as bool,
      (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_TestToJson(_$_Test instance) => <String, dynamic>{
      'name': instance.name,
      'open': instance.open,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
