part of 'take_test_cubit.dart';

class TakeTestState extends Equatable {
  final Test test;
  final List<UserQuestionAnswer> userAnswers;
  final int correctAnswers;

  final bool loading;

  TakeTestState({
    required this.test,
    required this.userAnswers,
    required this.correctAnswers,
    required this.loading,
  });

  TakeTestState copyWith({
    Test? test,
    List<UserQuestionAnswer>? userAnswers,
    int? correctAnswers,
    bool? loading,
  }) {
    return TakeTestState(
      test: test ?? this.test,
      userAnswers: userAnswers ?? this.userAnswers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [test, userAnswers, correctAnswers, loading];
}
