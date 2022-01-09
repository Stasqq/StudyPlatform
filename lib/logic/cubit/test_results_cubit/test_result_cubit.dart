import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/test/test.dart';
import 'package:study_platform/data/models/course/test/user_test_result.dart';
import 'package:study_platform/data/repositories/test_repository.dart';

part 'test_result_state.dart';

class TestResultCubit extends Cubit<TestResultState> {
  TestResultCubit({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(
          TestResultState(
            loading: false,
            results: [],
            maxScore: 0,
          ),
        );

  final TestRepository _testRepository;

  void loadTestResults({
    required String courseId,
    required Test test,
  }) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    List<UserTestResult> results =
        await _testRepository.getResults(test: test, courseId: courseId);

    emit(
      state.copyWith(
        loading: false,
        results: results,
        maxScore: test.questions.length,
      ),
    );
  }
}
