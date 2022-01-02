import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoState = context.watch<UserInfoCubit>().state;

    return StudyPlatformScaffold(
      title: kProfileScreenText,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(infoState.email.value),
            const SizedBox(height: 4),
            Text(infoState.firstName.value),
            const SizedBox(height: 4),
            Text(infoState.surname.value),
          ],
        ),
      ),
    );
  }
}
