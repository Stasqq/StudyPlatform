import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/create_test_cubit/create_test_cubit.dart';
import 'package:study_platform/logic/cubit/take_test_cubit/take_test_cubit.dart';
import 'package:study_platform/logic/cubit/test_results_cubit/test_result_cubit.dart';
import 'package:study_platform/logic/cubit/tests_cubit/tests_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool owner =
        (context.read<CoursesBloc>().state as CoursesStateLoadSuccess).owner;

    return StudyPlatformScaffold(
      title: kTestsScreenText,
      appBarActions: [
        Row(
          children: [
            if (owner)
              ElevatedButton(
                onPressed: () {
                  context.read<CreateTestCubit>().createTestStart(
                      courseId: (context.read<CoursesBloc>().state
                              as CoursesStateLoadSuccess)
                          .currentCourse
                          .id);
                  Navigator.of(context).pushNamed(kCreateTestScreen);
                },
                child: Icon(Icons.add),
                style: kAppBarButtonStyle,
              ),
            SizedBox(width: 8),
          ],
        ),
      ],
      child: BlocBuilder<TestsCubit, TestsState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tests.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.tests.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.tests[index].name,
                      style: kBigTextStyle,
                    ),
                    if ((context.read<CoursesBloc>().state
                            as CoursesStateLoadSuccess)
                        .joined)
                      Text(
                        kCurrentResult + state.getTestResultString(index),
                        style: kNormalTextStyle,
                      ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: state.tests[index].open
                              ? () {
                                  context
                                      .read<TakeTestCubit>()
                                      .setTest(state.tests[index]);
                                  Navigator.of(context).pushNamed(kTestScreen);
                                }
                              : null,
                          child: Text(kTestStart),
                          style: kButtonStyle,
                        ),
                        if ((context.read<CoursesBloc>().state
                                as CoursesStateLoadSuccess)
                            .owner)
                          Row(
                            children: [
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<TestsCubit>().changeOpen(
                                      state.tests[index],
                                      (context.read<CoursesBloc>().state
                                              as CoursesStateLoadSuccess)
                                          .currentCourse
                                          .id);
                                },
                                child: Text(
                                  state.tests[index].open ? kClose : kOpen,
                                ),
                                style: kButtonStyle,
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<TestResultCubit>()
                                      .loadTestResults(
                                          courseId: (context
                                                      .read<CoursesBloc>()
                                                      .state
                                                  as CoursesStateLoadSuccess)
                                              .currentCourse
                                              .id,
                                          test: state.tests[index]);
                                  Navigator.of(context)
                                      .pushNamed(kTestResultScreen);
                                },
                                child: Text(
                                  kResultsText,
                                ),
                                style: kButtonStyle,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: lightPrimaryColor);
              },
            );
          } else {
            return Center(
              child: Text(kNoAvailableTests),
            );
          }
        },
      ),
    );
  }
}
