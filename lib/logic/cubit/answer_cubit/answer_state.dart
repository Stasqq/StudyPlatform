part of 'answer_cubit.dart';

class AnswerState extends Equatable {
  final Answer answer;

  AnswerState({required this.answer});

  bool get isNotEmpty => this.answer.text.isNotEmpty;

  AnswerState copyWith({
    Answer? answer,
  }) {
    return AnswerState(
      answer: answer ?? this.answer,
    );
  }

  @override
  List<Object?> get props => [answer];
}
