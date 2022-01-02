import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final bool owner;
  late final bool joined;

  @override
  void initState() {
    owner = context.read<AuthenticationBloc>().state.user.uid == widget.course.ownerUid
        ? true
        : false;
    joined = context.read<UserInfoCubit>().state.joinedCourses.contains(widget.course.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: widget.course.name,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 2,
              //TODO: zamienic ten container na podstawowe informacje o kursie
              child: Container(),
            ),
            Expanded(
              flex: 3,
              //TODO: zamienic ten container na liste lekcji
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
