import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  const UserInfo(
      {required this.email,
      required this.firstName,
      required this.surname,
      this.uid,
      this.photoURL});

  final String? email;
  final String? uid;
  final String firstName;
  final String surname;
  final String? photoURL;

  static const Map<String, dynamic> emptyUserInfoMap = {
    'surname': '',
    'firstName': '',
  };

  static UserInfo empty = UserInfo.fromJson(emptyUserInfoMap);

  bool get isEmpty => this == UserInfo.empty;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'surname': surname,
      'photoURL': photoURL,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      uid: json['uid'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      surname: json['surname'] as String,
      photoURL: json['photoURL'] as String,
    );
  }

  @override
  List<Object?> get props => [uid, email, firstName, surname, photoURL];
}
