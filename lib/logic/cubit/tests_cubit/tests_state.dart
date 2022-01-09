part of 'tests_cubit.dart';

class TestsState extends Equatable {
  final List<Test> tests;

  final List<UserTestResult> currentUserTestsResults;

  final bool loading;
  final bool reload;

  String getTestResultString(int index) =>
      currentUserTestsResults[index].result.toString() +
      ' / ' +
      tests[index].questions.length.toString();

  TestsState({
    required this.loading,
    required this.reload,
    required this.tests,
    required this.currentUserTestsResults,
  });

  TestsState copyWith({
    List<Test>? tests,
    List<UserTestResult>? currentUserTestsResults,
    bool? loading,
    bool? reload,
  }) {
    return TestsState(
      tests: tests ?? this.tests,
      currentUserTestsResults:
          currentUserTestsResults ?? this.currentUserTestsResults,
      loading: loading ?? this.loading,
      reload: reload ?? this.reload,
    );
  }

  @override
  List<Object?> get props => [tests, currentUserTestsResults, reload, loading];
}
