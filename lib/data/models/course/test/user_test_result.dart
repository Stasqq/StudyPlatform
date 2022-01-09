import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_test_result.freezed.dart';
part 'user_test_result.g.dart';

@freezed
class UserTestResult with _$UserTestResult {
  const factory UserTestResult(String userId, String userName, int result) =
      _UserTestResult;
  factory UserTestResult.fromJson(Map<String, dynamic> json) =>
      _$UserTestResultFromJson(json);
}
