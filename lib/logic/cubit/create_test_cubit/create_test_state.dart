part of 'create_test_cubit.dart';

class CreateTestState extends Equatable {
  final Test test;
  final String courseId;

  final bool loading;
  final bool reload;

  bool get haveQuestions => test.questions.length > 0;

  int get nextQuestionNumber => test.questions.length + 1;

  bool get correctNameLength => test.name.length > 8 && test.name.length < 50;

  CreateTestState({
    required this.loading,
    required this.reload,
    required this.test,
    required this.courseId,
  });

  CreateTestState copyWith({
    Test? test,
    String? courseId,
    bool? loading,
    bool? reload,
  }) {
    return CreateTestState(
      test: test ?? this.test,
      courseId: courseId ?? this.courseId,
      loading: loading ?? this.loading,
      reload: reload ?? this.reload,
    );
  }

  @override
  List<Object?> get props => [test, courseId, loading, reload];
}
