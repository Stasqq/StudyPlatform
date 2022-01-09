import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_platform/data/models/course/test/answer.dart';

part 'user_question_answer.freezed.dart';
part 'user_question_answer.g.dart';

@freezed
class UserQuestionAnswer with _$UserQuestionAnswer {
  const factory UserQuestionAnswer(List<Answer> answers, List<bool> checked) =
      _UserQuestionAnswer;
  factory UserQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserQuestionAnswerFromJson(json);
}
