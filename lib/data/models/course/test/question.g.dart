// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$$_QuestionFromJson(Map json) => _$_Question(
      json['text'] as String,
      json['number'] as int,
      (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'text': instance.text,
      'number': instance.number,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };
