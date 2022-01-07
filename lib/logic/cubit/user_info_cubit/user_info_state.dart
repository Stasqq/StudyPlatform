part of 'user_info_cubit.dart';

enum NameValidationError { invalid }

class UserInfoState extends Equatable {
  const UserInfoState({
    this.firstName = const Name.pure(),
    this.surname = const Name.pure(),
    this.email = const Email.pure(),
    this.uid = '',
    this.photoURL = '',
    this.joinedCourses = const [],
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Name firstName;
  final Name surname;
  final Email email;
  final String photoURL;
  final String uid;
  final List<String> joinedCourses;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [firstName, photoURL, uid, surname, email, status, joinedCourses];

  UserInfoState copyWith({
    Name? firstName,
    Name? surname,
    Email? email,
    String? uid,
    String? photoURL,
    List<String>? joinedCourses,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return UserInfoState(
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      joinedCourses: joinedCourses ?? this.joinedCourses,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
