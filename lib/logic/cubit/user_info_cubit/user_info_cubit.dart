import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/data/forms/email_form.dart';
import 'package:study_platform/data/forms/name_form.dart';
import 'package:study_platform/data/models/user/user_info.dart';
import 'package:study_platform/data/repositories/authentication_repository.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(
      {required AuthenticationRepository authenticationRepository,
      required UserInfoRepository userInfoRepository})
      : _authenticationRepository = authenticationRepository,
        _userInfoRepository = userInfoRepository,
        super(const UserInfoState());

  final UserInfoRepository _userInfoRepository;
  final AuthenticationRepository _authenticationRepository;

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(state.copyWith(
        firstName: firstName,
        status: Formz.validate([
          firstName,
          state.surname,
        ])));
  }

  void surnameChanged(String value) {
    final surname = Name.dirty(value);
    emit(state.copyWith(
      surname: surname,
      status: Formz.validate([
        state.firstName,
        surname,
      ]),
    ));
  }

  Future<void> userInfoFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _userInfoRepository.saveUserInfoToFirebase(
          userInfo: UserInfo(
              _authenticationRepository.currentUser.email,
              _authenticationRepository.currentUser.uid,
              state.firstName.value,
              state.surname.value,
              null, []));
      emit(state.copyWith(
          email: Email.dirty(_authenticationRepository.currentUser.email),
          status: FormzStatus.submissionSuccess));
    } on SaveUserInfoToFirestoreFailure catch (e) {
      print(e);
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> readUserInfo() async {
    try {
      UserInfo userInfo = await _userInfoRepository.readUserInfo(
          email: _authenticationRepository.currentUser.email);
      emit(state.copyWith(
          firstName: Name.dirty(userInfo.firstName),
          surname: Name.dirty(userInfo.surname),
          email: Email.dirty(userInfo.email ?? ''),
          joinedCourses: userInfo.joinedCourses));
    } catch (e) {
      print(e);
      throw ReadUserInfoFromFirestoreFailure();
    }
  }
}
