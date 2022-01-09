import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const Course._();
  const factory Course(
      String id,
      String ownerEmail,
      String ownerName,
      String name,
      String description,
      bool public,
      int summaryRate,
      int ratesNumber) = _Course;
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  double getRate() {
    return this.ratesNumber == 0 ? 0 : this.summaryRate / this.ratesNumber;
  }
}
