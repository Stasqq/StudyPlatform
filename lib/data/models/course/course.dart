import 'package:freezed_annotation/freezed_annotation.dart';

import 'class.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const factory Course(String id, String ownerUid, String ownerName, String name,
      String description, bool public) = _Course;
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
