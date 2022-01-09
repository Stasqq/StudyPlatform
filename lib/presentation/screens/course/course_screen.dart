import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/other_user_info_cubit/other_user_info_cubit.dart';
import 'package:study_platform/logic/cubit/rate_course_cubit/rate_course_cubit.dart';
import 'package:study_platform/logic/cubit/tests_cubit/tests_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/screens/general/profile_screen.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

import '../../../logic/bloc/classes_bloc/classes_bloc.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: (context.read<CoursesBloc>().state as CoursesStateLoadSuccess)
          .currentCourse
          .name,
      appBarActions: [
        _RateDialogButton(),
      ],
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder<CoursesBloc, CoursesState>(
          buildWhen: (previous, current) =>
              (previous as CoursesStateLoadSuccess).joined !=
              (current as CoursesStateLoadSuccess).joined,
          builder: (context, state) {
            var loadState = state as CoursesStateLoadSuccess;
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
                              Text(loadState.currentCourse.description),
                              Text(loadState.getCurrentCourseRateString()),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: loadState.currentCourse.ownerName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context
                                              .read<OtherUserInfoCubit>()
                                              .loadOtherUserInfo(loadState
                                                  .currentCourse.ownerEmail);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen(
                                                      currentUser: false,
                                                    )),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              if (loadState.owner)
                                Text(loadState.currentCourse.id),
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
                              if (loadState.joined || loadState.owner)
                                Column(
                                  children: [
                                    _ChatButton(),
                                    _TestsButton(),
                                  ],
                                ),
                              if (!loadState.owner)
                                (loadState.joined)
                                    ? _LeaveButton()
                                    : _JoinButton(),
                              if (loadState.owner) _DeleteButton(),
                              if (loadState.owner) _NewClassDialogButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(kClassesText),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: BlocBuilder<ClassesBloc, ClassesState>(
                    builder: (context, state) {
                      if (state is ClassesStateLoading) {
                        return CircularProgressIndicator();
                      } else if (state is ClassesStateEmpty) {
                        return Text(kNoAvailableClasses);
                      } else if (state is ClassesStateLoadSuccess) {
                        return ListView.separated(
                          padding: EdgeInsets.all(8),
                          itemCount: state.hasMoreData
                              ? state.classes.length + 1
                              : state.classes.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= state.classes.length) {
                              context
                                  .read<ClassesBloc>()
                                  .add(ClassesEventFetchMore());
                              return Container(
                                margin: EdgeInsets.only(top: 15),
                                height: 30,
                                width: 30,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                            if (state is ClassesStateActionLoading)
                              return Center(child: CircularProgressIndicator());
                            return ListTile(
                              title: Text(state.classes[index].name),
                              subtitle: Text(state.classes[index].description),
                              trailing: ((context.read<CoursesBloc>().state
                                          as CoursesStateLoadSuccess)
                                      .owner)
                                  ? ElevatedButton(
                                      onPressed: () {
                                        context.read<ClassesBloc>().add(
                                            CurrentClassEvent(
                                                currentClass:
                                                    state.classes[index]));
                                        Navigator.of(context)
                                            .pushNamed(kClassEditScreen);
                                      },
                                      child: Icon(Icons.edit),
                                    )
                                  : SizedBox(),
                              onTap: () {
                                if ((context.read<CoursesBloc>().state
                                            as CoursesStateLoadSuccess)
                                        .owner ||
                                    (context.read<CoursesBloc>().state
                                            as CoursesStateLoadSuccess)
                                        .joined) {
                                  context.read<ClassesBloc>().add(
                                      CurrentClassEvent(
                                          currentClass: state.classes[index]));
                                  Navigator.of(context).pushNamed(kClassScreen);
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, i) {
                            return Divider();
                          },
                        );
                      } else {
                        return Text(kError);
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RateDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final rate = await _SimpleDialog.show(context);
        if (rate != null) {
          context.read<RateCourseCubit>().submitRating(
              courseId:
                  (context.read<CoursesBloc>().state as CoursesStateLoadSuccess)
                      .currentCourse
                      .id);
        }
      },
      child: Icon(Icons.star),
    );
  }
}

class _SimpleDialog extends StatelessWidget {
  const _SimpleDialog({
    Key? key,
  }) : super(key: key);

  static Future<int?> show(BuildContext context) async {
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) => _SimpleDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(kRateCourse),
      children: [
        BlocBuilder<RateCourseCubit, RateCourseState>(
          builder: (context, state) {
            return Column(children: [
              DropdownButton<int>(
                value: state.currentRate,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (rate) {
                  context.read<RateCourseCubit>().currentRateChanged(rate!);
                },
                items: <int>[5, 4, 3, 2, 1]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(state.currentRate);
                },
                child: Text(kConfirm),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(kCancel),
              ),
            ]);
          },
        ),
      ],
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
              Text(kChatText),
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
                  userEmail:
                      context.read<AuthenticationBloc>().state.user.email,
                  currentCoursesIds:
                      context.read<UserInfoCubit>().state.joinedCourses,
                ));
            context.read<UserInfoCubit>().readUserInfo();
          },
          child: const Text(kJoin),
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
                  userEmail:
                      context.read<AuthenticationBloc>().state.user.email,
                  currentCoursesIds:
                      context.read<UserInfoCubit>().state.joinedCourses,
                ));
            context.read<UserInfoCubit>().readUserInfo();
          },
          child: const Text(kLeave),
        );
      },
    );
  }
}

class _TestsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return ElevatedButton(
          style: kButtonStyle,
          onPressed: () {
            context.read<TestsCubit>().loadTests(
                  courseId: (context.read<CoursesBloc>().state
                          as CoursesStateLoadSuccess)
                      .currentCourse
                      .id,
                  userId: context.read<UserInfoCubit>().state.uid,
                );
            Navigator.of(context).pushNamed(kTestsScreen);
          },
          child: const Text(kTestsButton),
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
            Navigator.of(context).pop();
          },
          child: const Text(kDelete),
        );
      },
    );
  }
}

class _NewClassDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = '';
    String description = '';
    int index = 0;
    return ElevatedButton(
      style: kButtonStyle,
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: const Text(kEnterClassDescription),
          children: [
            TextField(
              onChanged: (value) => name = value,
            ),
            TextField(
              onChanged: (value) => description = value,
            ),
            TextField(
              onChanged: (value) => index = int.parse(value),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ClassesBloc>().add(ClassCreateEvent(
                    name: name, description: description, index: index));
                Navigator.of(context).pop();
              },
              child: Text(kConfirm),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(kCancel),
            ),
          ],
        ),
      ),
      child: Text(kAddClass),
    );
  }
}
