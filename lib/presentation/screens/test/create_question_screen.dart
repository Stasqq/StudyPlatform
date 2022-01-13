import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/data/models/course/test/answer.dart';
import 'package:study_platform/logic/cubit/answer_cubit/answer_cubit.dart';
import 'package:study_platform/logic/cubit/create_question_cubit/create_question_cubit.dart';
import 'package:study_platform/logic/cubit/create_test_cubit/create_test_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CreateQuestionScreen extends StatelessWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kCreateQuestionScreenText,
      appBarActions: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<CreateTestCubit>().creatingQuestionFinished(
                      context.read<CreateQuestionCubit>().state.question,
                    );
                Navigator.of(context).pop();
              },
              child: Icon(Icons.add),
              style: kAppBarButtonStyle,
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
      child: BlocBuilder<CreateQuestionCubit, CreateQuestionState>(
        builder: (BuildContext context, state) {
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QuestionTextInput(),
                const SizedBox(height: 8),
                _NewAnswerDialogButton(),
                const SizedBox(height: 8),
                _AnswersList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuestionTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQuestionCubit, CreateQuestionState>(
      builder: (context, state) {
        return TextField(
          onChanged: (text) =>
              context.read<CreateQuestionCubit>().textChanged(text),
          decoration: kTextFieldDecoration.copyWith(
            labelText: kQuestionTextLabel,
          ),
        );
      },
    );
  }
}

class _AnswersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQuestionCubit, CreateQuestionState>(
      builder: (context, state) {
        if (state.question.answers.isEmpty)
          return Text(kNoAnswersAdded);
        else
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.question.answers.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  state.question.answers[index].text,
                  style: TextStyle(
                    color: state.question.answers[index].correct
                        ? Colors.green
                        : Colors.black,
                    fontWeight: state.question.answers[index].correct
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                value: state.question.answers[index].correct,
                onChanged: (value) =>
                    context.read<CreateQuestionCubit>().changeAnswerCorrect(
                          state.question.answers[index],
                          value!,
                        ),
              );
            },
          );
      },
    );
  }
}

class _NewAnswerDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: kButtonStyle,
      onPressed: () async {
        final answer = await _SimpleDialog.show(context);
        if (answer != null) {
          context.read<CreateQuestionCubit>().addAnswer(answer);
        }
      },
      child: Text(kAddAnswer),
    );
  }
}

class _SimpleDialog extends StatelessWidget {
  const _SimpleDialog({
    Key? key,
  }) : super(key: key);

  static Future<Answer?> show(BuildContext context) async {
    return showDialog<Answer>(
      context: context,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => AnswerCubit(),
        child: _SimpleDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(kEnterAnswer),
      children: [
        BlocBuilder<AnswerCubit, AnswerState>(
          builder: (context, state) {
            return Column(children: [
              TextField(
                onChanged: (text) =>
                    context.read<AnswerCubit>().textChanged(text),
                decoration: kTextFieldDecoration,
              ),
              Row(
                children: [
                  Checkbox(
                    value: state.answer.correct,
                    onChanged: (value) =>
                        context.read<AnswerCubit>().correctChanged(value!),
                  ),
                  SizedBox(width: 4),
                  Text(kCorrectAnswer),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(state.answer);
                },
                child: Text(kConfirm),
                style: kButtonStyle,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(kCancel),
                style: kButtonStyle,
              ),
            ]);
          },
        ),
      ],
    );
  }
}
