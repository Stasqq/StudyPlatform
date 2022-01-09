import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/test/answer.dart';
import 'package:study_platform/data/models/course/test/question.dart';

part 'create_question_state.dart';

class CreateQuestionCubit extends Cubit<CreateQuestionState> {
  CreateQuestionCubit()
      : super(CreateQuestionState(
          loading: false,
          ready: false,
          question: Question('', 0, []),
        ));

  void createInit(int questionNumber) {
    emit(
      state.copyWith(
        question: Question('', questionNumber, []),
      ),
    );
  }

  void textChanged(String text) {
    Question newQuestion = state.question.copyWith(
      text: text,
    );
    emit(
      state.copyWith(
        question: newQuestion,
      ),
    );
  }

  void addAnswer(Answer answer) {
    emit(
      state.copyWith(
        question: state.question.copyWith(
          answers: [...state.question.answers, answer],
        ),
      ),
    );
  }

  void changeAnswerCorrect(Answer answer, bool value) {
    List<Answer> answers = state.question.answers;
    int answerIndex = answers.indexOf(answer);
    answers.remove(answer);
    List<Answer> newAnswersList = [...answers];
    newAnswersList.insert(answerIndex, answer.copyWith(correct: value));
    emit(
      state.copyWith(
        question: state.question.copyWith(
          answers: newAnswersList,
        ),
      ),
    );
  }
}
