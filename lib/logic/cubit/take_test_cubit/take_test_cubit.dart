import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/test/question.dart';
import 'package:study_platform/data/models/course/test/test.dart';
import 'package:study_platform/data/models/course/test/user_question_answer.dart';
import 'package:study_platform/data/models/course/test/user_test_result.dart';
import 'package:study_platform/data/repositories/test_repository.dart';

part 'take_test_state.dart';

class TakeTestCubit extends Cubit<TakeTestState> {
  TakeTestCubit({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(TakeTestState(
          loading: false,
          test: Test('', false, []),
          userAnswers: [],
          correctAnswers: 0,
        ));

  final TestRepository _testRepository;

  void setTest(Test test) {
    emit(
      state.copyWith(
        loading: true,
      ),
    );
    emit(
      state.copyWith(
        loading: false,
        userAnswers: _createUserAnswersList(test),
        correctAnswers: 0,
        test: test,
      ),
    );
  }

  List<UserQuestionAnswer> _createUserAnswersList(Test test) {
    List<UserQuestionAnswer> list = [];
    for (Question question in test.questions) {
      List<bool> boolList = [];
      question.answers.forEach((element) {
        boolList.add(false);
      });
      list.add(
        UserQuestionAnswer(question.answers, boolList),
      );
    }
    return list;
  }

  void userChangedAnswer(int questionNumber, int answerNumber, bool value) {
    List<UserQuestionAnswer> userAnswersNewList = [];
    for (int i = 0; i < state.test.questions.length; i++) {
      if (i != questionNumber)
        userAnswersNewList.add(state.userAnswers[i]);
      else {
        List<bool> newBoolList = [];
        for (int j = 0; j < state.userAnswers[i].answers.length; j++) {
          if (j != answerNumber)
            newBoolList.add(state.userAnswers[i].checked[j]);
          else
            newBoolList.add(value);
        }
        userAnswersNewList.add(
          UserQuestionAnswer(state.userAnswers[i].answers, newBoolList),
        );
      }
    }
    emit(
      state.copyWith(
        userAnswers: userAnswersNewList,
      ),
    );
  }

  Future<void> saveUserResult({
    required String userId,
    required String userName,
    required String courseId,
  }) async {
    emit(
      state.copyWith(loading: true),
    );
    await _calculateCorrectAnswers();
    await _testRepository.saveUserResult(
      userTestResult: UserTestResult(userId, userName, state.correctAnswers),
      courseId: courseId,
      testName: state.test.name,
    );
    emit(
      state.copyWith(loading: false),
    );
  }

  Future<void> _calculateCorrectAnswers() async {
    int correctQuestionAnswers = 0;
    for (int i = 0; i < state.userAnswers.length; i++) {
      if (_isUserAnswerCorrect(state.userAnswers[i])) correctQuestionAnswers++;
    }
    emit(
      state.copyWith(
        correctAnswers: correctQuestionAnswers,
      ),
    );
  }

  bool _isUserAnswerCorrect(UserQuestionAnswer userQuestionAnswer) {
    for (int i = 0; i < userQuestionAnswer.answers.length; i++) {
      if (userQuestionAnswer.answers[i].correct !=
          userQuestionAnswer.checked[i]) return false;
    }
    return true;
  }
}
