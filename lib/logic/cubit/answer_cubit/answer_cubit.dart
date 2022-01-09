import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/test/answer.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  AnswerCubit()
      : super(AnswerState(
          answer: Answer('', false),
        ));

  void correctChanged(bool correct) {
    emit(
      state.copyWith(
        answer: state.answer.copyWith(correct: correct),
      ),
    );
  }

  void textChanged(String text) {
    emit(
      state.copyWith(
        answer: state.answer.copyWith(text: text),
      ),
    );
  }
}
