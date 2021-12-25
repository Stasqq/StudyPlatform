import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_platform/constants/variables.dart';
import 'package:study_platform/presentation/widgets/study_platform_drawer.dart';

class StudyPlatformScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const StudyPlatformScaffold({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
