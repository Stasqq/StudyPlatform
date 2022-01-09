part of 'test_result_cubit.dart';

class TestResultState extends Equatable {
  final List<UserTestResult> results;
  final int maxScore;

  final bool loading;

  TestResultState({
    required this.loading,
    required this.results,
    required this.maxScore,
  });

  String pointsString(int index) =>
      results[index].result.toString() + ' / ' + maxScore.toString();

  TestResultState copyWith({
    List<UserTestResult>? results,
    bool? loading,
    int? maxScore,
  }) {
    return TestResultState(
      loading: loading ?? this.loading,
      results: results ?? this.results,
      maxScore: maxScore ?? this.maxScore,
    );
  }

  @override
  List<Object?> get props => [results, loading];
}
