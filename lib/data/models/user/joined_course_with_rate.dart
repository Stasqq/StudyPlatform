import 'package:freezed_annotation/freezed_annotation.dart';

part 'joined_course_with_rate.freezed.dart';
part 'joined_course_with_rate.g.dart';

@freezed
class JoinedCourseWithRate with _$JoinedCourseWithRate {
  const factory JoinedCourseWithRate(String courseId, int rate) =
      _JoinedCourseWithRate;
  factory JoinedCourseWithRate.fromJson(Map<String, dynamic> json) =>
      _$JoinedCourseWithRateFromJson(json);
}
