import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/data/forms/email_form.dart';
import 'package:study_platform/data/forms/name_form.dart';
import 'package:study_platform/data/models/user/joined_course_with_rate.dart';
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

    emit(
      state.copyWith(
        firstName: firstName,
        status: Formz.validate(
          [
            firstName,
            state.surname,
          ],
        ),
      ),
    );
  }

  void surnameChanged(String value) {
    final surname = Name.dirty(value);

    emit(
      state.copyWith(
        surname: surname,
        status: Formz.validate(
          [
            state.firstName,
            surname,
          ],
        ),
      ),
    );
  }

  Future<void> userInfoFormSubmitted() async {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );

    try {
      await _userInfoRepository.saveUserInfoToFirebase(
        userInfo: UserInfo(
          _authenticationRepository.currentUser.email,
          _authenticationRepository.currentUser.uid,
          state.firstName.value,
          state.surname.value,
          '',
          [],
        ),
      );

      emit(
        state.copyWith(
            email: Email.dirty(_authenticationRepository.currentUser.email),
            status: FormzStatus.submissionSuccess),
      );
    } on SaveUserInfoToFirestoreFailure catch (e) {
      print(e);
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> readUserInfo() async {
    try {
      UserInfo userInfo = await _userInfoRepository.readUserInfo(
        email: _authenticationRepository.currentUser.email,
      );

      emit(
        state.copyWith(
          firstName: Name.dirty(userInfo.firstName),
          surname: Name.dirty(userInfo.surname),
          photoURL: userInfo.photoPath,
          email: Email.dirty(userInfo.email ?? ''),
          uid: userInfo.uid,
          joinedCourses: userInfo.joinedCourses,
        ),
      );
    } catch (e) {
      print(e);
      throw ReadUserInfoFromFirestoreFailure();
    }
  }

  UserInfo getUserInfoObject() {
    return UserInfo(state.email.value, state.uid, state.firstName.value,
        state.surname.value, state.photoURL, state.joinedCourses);
  }

  void joinCourse(String courseId) {
    List<JoinedCourseWithRate> newCoursesList = state.joinedCourses;
    newCoursesList.add(JoinedCourseWithRate(courseId, 0));

    emit(
      state.copyWith(
        joinedCourses: newCoursesList,
      ),
    );
  }

  void leaveCourse(String courseId) {
    List<JoinedCourseWithRate> newCoursesList = state.joinedCourses;
    newCoursesList.remove(courseId);

    emit(
      state.copyWith(
        joinedCourses: newCoursesList,
      ),
    );
  }

  void updateCourseRate(String courseId, int rate) {
    List<JoinedCourseWithRate> newJoinedCourses = [];

    for (int i = 0; i < state.joinedCourses.length; i++) {
      if (state.joinedCourses[i].courseId == courseId)
        newJoinedCourses.add(JoinedCourseWithRate(courseId, rate));
      else
        newJoinedCourses.add(state.joinedCourses[i]);
    }

    _userInfoRepository.updateJoinedCourses(
        userEmail: state.email.value, joinedCourses: newJoinedCourses);

    emit(
      state.copyWith(
        joinedCourses: newJoinedCourses,
      ),
    );
  }
}
