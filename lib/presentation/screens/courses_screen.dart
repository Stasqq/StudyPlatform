import 'package:flutter/material.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kCoursesScreenText,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        //TODO: create CoursesScreen
        child: Container(),
      ),
    );
  }
}
