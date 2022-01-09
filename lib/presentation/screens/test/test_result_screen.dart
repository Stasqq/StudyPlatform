import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/cubit/test_results_cubit/test_result_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kResultsText,
      child: BlocBuilder<TestResultCubit, TestResultState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.results.isNotEmpty) {
            return ListView.separated(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.results[index].userName),
                  subtitle: Text(state.pointsString(index)),
                );
              },
              separatorBuilder: (context, i) {
                return Divider();
              },
            );
          } else {
            return Center(child: Text(kNoAvailableResults));
          }
        },
      ),
    );
  }
}
