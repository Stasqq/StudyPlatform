import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kHomeScreenText,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              context.select((UserInfoCubit cubit) => cubit.state.email).value,
            ),
            const SizedBox(height: 4),
            Text(
              context.select((UserInfoCubit cubit) => cubit.state.firstName).value,
            ),
            const SizedBox(height: 4),
            Text(
              context.select((UserInfoCubit cubit) => cubit.state.surname).value,
            ),
          ],
        ),
      ),
    );
  }
}
