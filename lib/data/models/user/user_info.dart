import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_platform/data/models/user/joined_course_with_rate.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo(
      String? email,
      String? uid,
      String firstName,
      String surname,
      String? photoURL,
      List<JoinedCourseWithRate> joinedCourses) = _UserInfo;
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
