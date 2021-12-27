import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/data/forms/course_name_form.dart';
import 'package:study_platform/data/models/course/class.dart';
import 'package:study_platform/data/repositories/authentication_repository.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required AuthenticationRepository authenticationRepository,
    required CoursesRepository coursesRepository,
  })  : _authenticationRepository = authenticationRepository,
        _coursesRepository = coursesRepository,
        super(const CourseState());

  final AuthenticationRepository _authenticationRepository;
  final CoursesRepository _coursesRepository;

  void courseNameChanged(String value) {
    final courseName = CourseName.dirty(value);

    emit(state.copyWith(
      courseName: courseName,
      status: Formz.validate([
        courseName,
      ]),
    ));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(
      description: value,
    ));
  }

  void publicChanged(bool value) {
    emit(state.copyWith(
      public: value,
    ));
  }

  Future<void> createCourseFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _coursesRepository.createCourse(
        courseName: state.courseName.value,
        description: state.description ?? '',
        ownerUid: _authenticationRepository.currentUser.uid,
        public: state.public,
      );
      emit(state.copyWith(
          ownerUid: _authenticationRepository.currentUser.uid,
          status: FormzStatus.submissionSuccess));
    } on SaveNewCourseToFirestoreFailure catch (e) {
      print(e);
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
