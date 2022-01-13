import 'package:flutter/material.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/variables.dart';
import 'package:study_platform/presentation/widgets/study_platform_drawer.dart';

class StudyPlatformScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? appBarActions;
  final FloatingActionButton? floatingActionButton;

  const StudyPlatformScaffold(
      {Key? key,
      required this.title,
      required this.child,
      this.appBarActions,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: appBarActions,
        backgroundColor: primaryColor,
      ),
      floatingActionButton: floatingActionButton,
      drawer: kInvisibleDrawerScreensTitles.contains(title)
          ? null
          : const StudyPlatformDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
