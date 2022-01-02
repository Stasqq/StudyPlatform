import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    context.read<CoursesBloc>().add(CoursesEventStart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
        title: kCoursesScreenText,
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
                    itemCount: state.hasMoreData
                        ? state.courses.length + 1
                        : state.courses.length,
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
        ));
  }
}
