import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User(String email, String uid) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static const empty = User('', '');
}
