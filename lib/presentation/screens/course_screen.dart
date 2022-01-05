import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

import '../../logic/bloc/classes_bloc/classes_bloc.dart';

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
                              if (state.owner) _NewClassDialog(),
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
                    child: Text('Classes'),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: BlocBuilder<ClassesBloc, ClassesState>(
                    builder: (context, state) {
                      if (state is ClassesStateLoading) {
                        return CircularProgressIndicator();
                      } else if (state is ClassesStateEmpty) {
                        return Text('No available classes!');
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
                                  : Container(),
                              onTap: () {
                                //TODO: wyswietlanie pojedynczej classy
                              },
                            );
                          },
                          separatorBuilder: (context, i) {
                            return Divider();
                          },
                        );
                      } else {
                        return Text('Error');
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
                  userEmail:
                      context.read<AuthenticationBloc>().state.user.email,
                  currentCoursesIds:
                      context.read<UserInfoCubit>().state.joinedCourses,
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
                  userEmail:
                      context.read<AuthenticationBloc>().state.user.email,
                  currentCoursesIds:
                      context.read<UserInfoCubit>().state.joinedCourses,
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
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        );
      },
    );
  }
}

class _NewClassDialog extends StatelessWidget {
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
          title: const Text('Enter Class Description'),
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
              child: Text('Confirm'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
      child: Text('Add Class'),
    );
  }
}
