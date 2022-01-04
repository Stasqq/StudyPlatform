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
  List<Object> get props => [coursesFilter, joinedCourses];
}

class CoursesEventLoad extends CoursesEvent {
  final List<List<Course>> courses;

  const CoursesEventLoad(this.courses);

  @override
  List<Object> get props => [courses];
}

class CoursesEventFetchMore extends CoursesEvent {}

class CurrentCourseEvent extends CoursesEvent {
  final Course currentCourse;
  final bool owner;
  final bool joined;

  CurrentCourseEvent(
      {required this.currentCourse, required this.owner, required this.joined});

  @override
  List<Object> get props => [currentCourse, owner, joined];
}

class CurrentCourseJoinEvent extends CoursesEvent {
  final List<String> currentCoursesIds;
  final String userEmail;

  CurrentCourseJoinEvent({required this.userEmail, required this.currentCoursesIds});

  @override
  List<Object> get props => [userEmail, currentCoursesIds];
}

class CurrentCourseLeaveEvent extends CoursesEvent {
  final List<String> currentCoursesIds;
  final String userEmail;

  CurrentCourseLeaveEvent({required this.userEmail, required this.currentCoursesIds});

  @override
  List<Object> get props => [userEmail, currentCoursesIds];
}

class CourseJoinEvent extends CoursesEvent {
  final List<String> currentCoursesIds;
  final String userEmail;
  final String courseId;

  CourseJoinEvent(
      {required this.currentCoursesIds, required this.userEmail, required this.courseId});

  @override
  List<Object> get props => [userEmail, currentCoursesIds, courseId];
}

class CurrentCourseDeleteEvent extends CoursesEvent {}
