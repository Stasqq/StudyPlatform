import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: (context.read<CoursesBloc>().state as CoursesStateLoadSuccess)
          .currentCourse
          .name,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder<CoursesBloc, CoursesState>(
          buildWhen: (previous, current) =>
              (previous as CoursesStateLoadSuccess).joined !=
              (current as CoursesStateLoadSuccess).joined,
          builder: (context, state) {
            state = state as CoursesStateLoadSuccess;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.currentCourse.description),
                              Text(state.currentCourse.ownerName),
                              if (state.owner) Text(state.currentCourse.id),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state.joined || state.owner) _ChatButton(),
                              if (!state.owner)
                                (state.joined) ? _LeaveButton() : _JoinButton(),
                              if (state.owner) _DeleteButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  //TODO: zamienic ten container na liste lekcji
                  child: Container(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return ElevatedButton(
          style: kButtonStyle,
          onPressed: () {
            Navigator.of(context).pushNamed(kChatScreen);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat,
              ),
              SizedBox(width: 8),
              Text('Chat'),
            ],
          ),
        );
      },
    );
  }
}

class _JoinButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return ElevatedButton(
          style: kButtonStyle,
          onPressed: () {
            context.read<CoursesBloc>().add(CurrentCourseJoinEvent(
                  userEmail: context.read<AuthenticationBloc>().state.user.email,
                  currentCoursesIds: context.read<UserInfoCubit>().state.joinedCourses,
                ));
            context.read<UserInfoCubit>().readUserInfo();
          },
          child: const Text('Join'),
        );
      },
    );
  }
}

class _LeaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return ElevatedButton(
          style: kButtonStyle,
          onPressed: () {
            context.read<CoursesBloc>().add(CurrentCourseLeaveEvent(
                  userEmail: context.read<AuthenticationBloc>().state.user.email,
                  currentCoursesIds: context.read<UserInfoCubit>().state.joinedCourses,
                ));
            context.read<UserInfoCubit>().readUserInfo();
          },
          child: const Text('Leave'),
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return ElevatedButton(
          style: kButtonStyle,
          onPressed: () {
            context.read<CoursesBloc>().add(CurrentCourseDeleteEvent());
          },
          child: const Text('Delete'),
        );
      },
    );
  }
}
