import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

import '../../../logic/bloc/classes_bloc/classes_bloc.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final filterItems = [
    CoursesFilter.Public,
    CoursesFilter.Joined,
    CoursesFilter.Owner
  ];
  CoursesFilter filter = CoursesFilter.Public;
  late final String currentUserEmail;

  @override
  void initState() {
    currentUserEmail = context.read<AuthenticationBloc>().state.user.email;
    if (!(context.read<CoursesBloc>().state is CoursesStateLoadSuccess))
      context.read<CoursesBloc>().add(CoursesEventStart(coursesFilter: filter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kCoursesScreenText,
      appBarActions: [
        Row(
          children: [
            JoinCourseDialogButton(),
            SizedBox(width: 8),
            Icon(Icons.filter_list),
            SizedBox(width: 8),
            DropdownButton(
              value: filter,
              items: filterItems.map(buildMenuItem).toList(),
              dropdownColor: accentColor,
              onChanged: (value) {
                setState(() {
                  filter = value as CoursesFilter;
                });
                context.read<CoursesBloc>().add(
                      CoursesEventStart(
                        coursesFilter: filter,
                        ownerEmail: currentUserEmail,
                        joinedCourses:
                            context.read<UserInfoCubit>().state.joinedCourses,
                      ),
                    );
              },
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Center(
          child: BlocBuilder<CoursesBloc, CoursesState>(
            builder: (context, state) {
              if (state is CoursesStateLoading) {
                return CircularProgressIndicator();
              } else if (state is CoursesStateEmpty) {
                return Text(kNoAvailableCourses);
              } else if (state is CoursesStateLoadSuccess) {
                return ListView.separated(
                  padding: EdgeInsets.all(8),
                  itemCount: state.hasMoreData
                      ? state.courses.length + 1
                      : state.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.courses.length) {
                      context.read<CoursesBloc>().add(
                            CoursesEventFetchMore(
                              coursesFilter: filter,
                              ownerEmail: currentUserEmail,
                              joinedCourses: context
                                  .read<UserInfoCubit>()
                                  .state
                                  .joinedCourses,
                            ),
                          );
                      return Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 30,
                        width: 30,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        context.read<CoursesBloc>().add(CurrentCourseEvent(
                            currentCourse: state.courses[index],
                            owner: currentUserEmail ==
                                state.courses[index].ownerEmail,
                            joined: context
                                .read<UserInfoCubit>()
                                .state
                                .joinedCourseWithId(state.courses[index].id)));
                        context.read<ClassesBloc>().add(ClassesEventStart(
                            courseId: state.courses[index].id));
                        Navigator.of(context).pushNamed(kCourseScreen);
                      },
                      child: Column(
                        children: [
                          Text(state.courses[index].name),
                          Text(
                            state.courses[index].description,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(state.getCourseRateString(index)),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: lightPrimaryColor,
                    );
                  },
                );
              } else {
                return Text(kError);
              }
            },
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<CoursesFilter> buildMenuItem(CoursesFilter item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          EnumToString.convertToString(item),
          style: TextStyle(color: textIconsColor),
        ),
      );
}

class JoinCourseDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String courseId = '';
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: const Text(kEnterCourseId),
          children: [
            Column(
              children: [
                TextField(
                  onChanged: (id) => courseId = id,
                  decoration: kTextFieldDecoration,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CoursesBloc>().add(CourseJoinEvent(
                          userEmail: context
                              .read<AuthenticationBloc>()
                              .state
                              .user
                              .email,
                          currentCoursesIds:
                              context.read<UserInfoCubit>().state.joinedCourses,
                          courseId: courseId,
                        ));
                    context.read<UserInfoCubit>().readUserInfo();
                    Navigator.of(context).pop();
                  },
                  child: Text(kJoin),
                  style: kButtonStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(kCancel),
                  style: kButtonStyle,
                ),
              ],
            ),
          ],
        ),
      ),
      child: Text(kJoinCourse),
      style: kButtonStyle,
    );
  }
}
