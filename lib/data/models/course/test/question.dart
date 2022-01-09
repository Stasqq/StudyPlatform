import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_platform/data/models/course/test/answer.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question(String text, int number, List<Answer> answers) =
      _Question;
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
