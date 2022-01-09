import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_platform/data/models/course/test/question.dart';

part 'test.freezed.dart';
part 'test.g.dart';

@freezed
class Test with _$Test {
  const factory Test(String name, bool open, List<Question> questions) = _Test;
  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
}
