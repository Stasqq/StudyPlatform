import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final filterItems = [CoursesFilter.All, CoursesFilter.Joined, CoursesFilter.Owner];
  CoursesFilter filter = CoursesFilter.All;
  late final String ownerUid;
  late final List<String> joinedCourses;

  @override
  void initState() {
    ownerUid = context.read<AuthenticationBloc>().state.user.uid;
    joinedCourses = context.read<UserInfoCubit>().state.joinedCourses;
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
            Icon(Icons.filter_list),
            SizedBox(width: 8),
            DropdownButton(
              value: filter,
              items: filterItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  filter = value as CoursesFilter;
                });
                context.read<CoursesBloc>().add(
                      CoursesEventStart(
                        coursesFilter: filter,
                        ownerUid: ownerUid,
                        joinedCourses: joinedCourses,
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
                return Text('No available courses!');
              } else if (state is CoursesStateLoadSuccess) {
                return ListView.separated(
                  padding: EdgeInsets.all(8),
                  itemCount:
                      state.hasMoreData ? state.courses.length + 1 : state.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.courses.length) {
                      context.read<CoursesBloc>().add(CoursesEventFetchMore());
                      return Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 30,
                        width: 30,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return ListTile(
                      title: Text(state.courses[index].name),
                      subtitle: Text(state.courses[index].description),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(kCourseScreen, arguments: state.courses[index]);
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
      ),
    );
  }

  DropdownMenuItem<CoursesFilter> buildMenuItem(CoursesFilter item) => DropdownMenuItem(
        value: item,
        child: Text(
          EnumToString.convertToString(item),
        ),
      );
}
