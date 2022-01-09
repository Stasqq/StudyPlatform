part of 'create_question_cubit.dart';

class CreateQuestionState extends Equatable {
  final Question question;

  final bool loading;
  final bool ready;

  CreateQuestionState({
    required this.loading,
    required this.ready,
    required this.question,
  });

  CreateQuestionState copyWith({
    Question? question,
    bool? loading,
    bool? ready,
  }) {
    return CreateQuestionState(
      loading: loading ?? this.loading,
      ready: ready ?? this.ready,
      question: question ?? this.question,
    );
  }

  @override
  List<Object?> get props => [question, loading, ready];
}
