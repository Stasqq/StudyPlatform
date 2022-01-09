// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserQuestionAnswer _$$_UserQuestionAnswerFromJson(Map json) =>
    _$_UserQuestionAnswer(
      (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      (json['checked'] as List<dynamic>).map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$$_UserQuestionAnswerToJson(
        _$_UserQuestionAnswer instance) =>
    <String, dynamic>{
      'answers': instance.answers.map((e) => e.toJson()).toList(),
      'checked': instance.checked,
    };
