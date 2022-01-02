part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class CoursesEventStart extends CoursesEvent {
  const CoursesEventStart(
      {required this.coursesFilter, this.ownerUid, List<String>? joinedCourses})
      : joinedCourses = joinedCourses ?? const [];

  final CoursesFilter coursesFilter;
  final String? ownerUid;
  final List<String> joinedCourses;

  @override
  List<Object> get props => [coursesFilter];
}

class CoursesEventLoad extends CoursesEvent {
  final List<List<Course>> courses;

  const CoursesEventLoad(this.courses);

  @override
  List<Object> get props => [courses];
}

class CoursesEventFetchMore extends CoursesEvent {}
