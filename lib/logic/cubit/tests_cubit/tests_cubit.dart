import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/test/test.dart';
import 'package:study_platform/data/models/course/test/user_test_result.dart';
import 'package:study_platform/data/repositories/test_repository.dart';

part 'tests_state.dart';

class TestsCubit extends Cubit<TestsState> {
  TestsCubit({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(TestsState(
          tests: [],
          currentUserTestsResults: [],
          loading: false,
          reload: true,
        ));

  final TestRepository _testRepository;

  void loadTests({
    required String courseId,
    required String userId,
  }) async {
    emit(
      state.copyWith(
        loading: true,
        reload: false,
      ),
    );

    List<Test> tests = await _testRepository.getCourseTests(
      courseId: courseId,
    );

    List<UserTestResult> currentUserTestsResults = [];
    for (int i = 0; i < tests.length; i++) {
      UserTestResult singleResult = await _testRepository.getUserResult(
        userId: userId,
        courseId: courseId,
        testName: tests[i].name,
      );
      currentUserTestsResults.add(singleResult);
    }

    emit(
      state.copyWith(
        tests: tests,
        currentUserTestsResults: currentUserTestsResults,
        loading: false,
        reload: true,
      ),
    );
  }

  void changeOpen(Test test, String courseId) async {
    Test newTest = test.copyWith(
      open: !test.open,
    );
    await _testRepository.updateTestOpen(
      test: newTest,
      courseId: courseId,
    );
    int testIndex = state.tests.indexOf(test);
    List<Test> newTestsList = [...state.tests];
    newTestsList.remove(test);
    newTestsList.insert(
      testIndex,
      newTest,
    );
    emit(
      state.copyWith(
        loading: false,
        tests: newTestsList,
      ),
    );
  }
}
