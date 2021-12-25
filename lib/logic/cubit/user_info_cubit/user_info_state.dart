part of 'user_info_cubit.dart';

enum NameValidationError { invalid }

class UserInfoState extends Equatable {
  const UserInfoState({
    this.firstName = const Name.pure(),
    this.surname = const Name.pure(),
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Name firstName;
  final Name surname;
  final Email email;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [firstName, surname, email, status];

  UserInfoState copyWith({
    Name? firstName,
    Name? surname,
    Email? email,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return UserInfoState(
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
