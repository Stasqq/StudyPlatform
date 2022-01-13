import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/take_test_cubit/take_test_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class TakingTestScreen extends StatelessWidget {
  const TakingTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: context.read<TakeTestCubit>().state.test.name,
      appBarActions: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                await context.read<TakeTestCubit>().saveUserResult(
                      userId: context.read<UserInfoCubit>().state.uid,
                      userName: context.read<UserInfoCubit>().state.userName,
                      courseId: (context.read<CoursesBloc>().state
                              as CoursesStateLoadSuccess)
                          .currentCourse
                          .id,
                    );
                Navigator.of(context).pop();
              },
              child: Icon(Icons.save),
              style: kAppBarButtonStyle,
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Center(
          child: BlocBuilder<TakeTestCubit, TakeTestState>(
            builder: (context, state) {
              if (state.loading) {
                return CircularProgressIndicator();
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.test.questions.length,
                  itemBuilder: (context, questionIndex) {
                    return Column(
                      children: [
                        Text(
                          kQuestion +
                              state.test.questions[questionIndex].number
                                  .toString(),
                          style: kBigTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          state.test.questions[questionIndex].text,
                          style: kNormalTextStyle,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state
                                .test.questions[questionIndex].answers.length,
                            itemBuilder: (context, answerIndex) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: state.userAnswers[questionIndex]
                                        .checked[answerIndex],
                                    onChanged: (value) {
                                      context
                                          .read<TakeTestCubit>()
                                          .userChangedAnswer(questionIndex,
                                              answerIndex, value!);
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      state.userAnswers[questionIndex]
                                          .answers[answerIndex].text,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
                  },
                  separatorBuilder: (context, i) {
                    return Divider();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
