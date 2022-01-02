import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo(String? email, String? uid, String firstName, String surname,
      String? photoURL, List<String> joinedCourses) = _UserInfo;
  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}
