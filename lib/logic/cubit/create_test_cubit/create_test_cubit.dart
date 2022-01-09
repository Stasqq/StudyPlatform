import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/test/question.dart';
import 'package:study_platform/data/models/course/test/test.dart';
import 'package:study_platform/data/repositories/test_repository.dart';

part 'create_test_state.dart';

class CreateTestCubit extends Cubit<CreateTestState> {
  CreateTestCubit({
    required TestRepository testRepository,
  })  : _testRepository = testRepository,
        super(CreateTestState(
          courseId: '',
          test: Test('', false, []),
          loading: false,
          reload: true,
        ));

  final TestRepository _testRepository;

  void createTestStart({
    required String courseId,
  }) {
    emit(
      state.copyWith(
        courseId: courseId,
      ),
    );
  }

  void visibleChange(bool open) {
    emit(
      state.copyWith(
        test: state.test.copyWith(
          open: open,
        ),
      ),
    );
  }

  void nameChange(String name) {
    emit(
      state.copyWith(
        test: state.test.copyWith(name: name),
      ),
    );
  }

  void creatingQuestion() {
    emit(
      state.copyWith(
        loading: true,
        reload: false,
      ),
    );
  }

  void creatingQuestionFinished(Question question) {
    emit(
      state.copyWith(
        test: state.test.copyWith(
          questions: [...state.test.questions, question],
        ),
        loading: false,
        reload: true,
      ),
    );
  }

  void creatingFinished() async {
    emit(
      state.copyWith(
        loading: true,
        reload: false,
      ),
    );
    await _testRepository.saveTest(
      test: state.test,
      courseId: state.courseId,
    );
    emit(
      state.copyWith(
        loading: false,
        reload: true,
      ),
    );
  }
}
