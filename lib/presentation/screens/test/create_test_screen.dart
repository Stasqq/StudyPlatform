import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/cubit/create_question_cubit/create_question_cubit.dart';
import 'package:study_platform/logic/cubit/create_test_cubit/create_test_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CreateTestScreen extends StatelessWidget {
  const CreateTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kCreateTestScreenText,
      appBarActions: [
        ElevatedButton(
          onPressed: () async {
            context.read<CreateTestCubit>().creatingFinished();
          },
          child: Icon(Icons.save),
        )
      ],
      child: BlocBuilder<CreateTestCubit, CreateTestState>(
        builder: (context, state) {
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TestNameInput(),
                const SizedBox(height: 8),
                _OpenInput(),
                const SizedBox(height: 8),
                _NewQuestionButton(),
                const SizedBox(height: 8),
                _QuestionsListTile(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TestNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTestCubit, CreateTestState>(
      buildWhen: (previous, current) => previous.test.name != current.test.name,
      builder: (context, state) {
        if (state.reload) {
          return TextField(
            onChanged: (value) =>
                context.read<CreateTestCubit>().nameChange(value),
            decoration: InputDecoration(
              labelText: kCourseNameLabel,
              helperText: kCourseNameLabelHelper,
              errorText: state.correctNameLength ? null : kTestNameLabelInvalid,
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

class _OpenInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTestCubit, CreateTestState>(
      builder: (context, state) {
        if (state.reload) {
          return Row(
            children: [
              Checkbox(
                value: state.test.open,
                onChanged: (value) {
                  context.read<CreateTestCubit>().visibleChange(value!);
                },
              ),
              SizedBox(width: 8),
              Text(kSetOpen),
            ],
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

class _NewQuestionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTestCubit, CreateTestState>(
      builder: (context, state) {
        if (state.reload) {
          return ElevatedButton(
            style: kButtonStyle,
            onPressed: () {
              context.read<CreateTestCubit>().creatingQuestion();
              context
                  .read<CreateQuestionCubit>()
                  .createInit(state.nextQuestionNumber);
              Navigator.of(context).pushNamed(kCreateQuestionScreen);
            },
            child: const Text(kAddQuestion),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

class _QuestionsListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTestCubit, CreateTestState>(
      builder: (context, state) {
        if (state.reload) {
          if (!state.haveQuestions)
            return Text(kNoQuestionAdded);
          else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.test.questions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(state.test.questions[index].text),
                );
              },
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
