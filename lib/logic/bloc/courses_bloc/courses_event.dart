part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class CoursesEventStart extends CoursesEvent {
  const CoursesEventStart({
    required this.coursesFilter,
    this.ownerEmail,
    List<JoinedCourseWithRate>? joinedCourses,
  }) : joinedCourses = joinedCourses ?? const [];

  final CoursesFilter coursesFilter;
  final String? ownerEmail;
  final List<JoinedCourseWithRate> joinedCourses;

  @override
  List<Object> get props => [coursesFilter, joinedCourses];
}

class CoursesEventLoad extends CoursesEvent {
  final List<List<Course>> courses;

  const CoursesEventLoad(this.courses);

  @override
  List<Object> get props => [courses];
}

class CoursesEventFetchMore extends CoursesEvent {
  final CoursesFilter coursesFilter;
  final String? ownerEmail;
  final List<JoinedCourseWithRate> joinedCourses;

  CoursesEventFetchMore({
    required this.coursesFilter,
    required this.ownerEmail,
    required this.joinedCourses,
  });

  @override
  List<Object> get props => [coursesFilter, joinedCourses];
}

class CurrentCourseEvent extends CoursesEvent {
  final Course currentCourse;
  final bool owner;
  final bool joined;

  CurrentCourseEvent({
    required this.currentCourse,
    required this.owner,
    required this.joined,
  });

  @override
  List<Object> get props => [currentCourse, owner, joined];
}

class CurrentCourseJoinEvent extends CoursesEvent {
  final List<JoinedCourseWithRate> currentCoursesIds;
  final String userEmail;

  CurrentCourseJoinEvent({
    required this.userEmail,
    required this.currentCoursesIds,
  });

  @override
  List<Object> get props => [userEmail, currentCoursesIds];
}

class CurrentCourseLeaveEvent extends CoursesEvent {
  final List<JoinedCourseWithRate> currentCoursesIds;
  final String userEmail;

  CurrentCourseLeaveEvent({
    required this.userEmail,
    required this.currentCoursesIds,
  });

  @override
  List<Object> get props => [userEmail, currentCoursesIds];
}

class CourseJoinEvent extends CoursesEvent {
  final List<JoinedCourseWithRate> currentCoursesIds;
  final String userEmail;
  final String courseId;

  CourseJoinEvent({
    required this.currentCoursesIds,
    required this.userEmail,
    required this.courseId,
  });

  @override
  List<Object> get props => [userEmail, currentCoursesIds, courseId];
}

class CurrentCourseDeleteEvent extends CoursesEvent {}

class CurrentCourseRateUpdateEvent extends CoursesEvent {
  final int rate;

  CurrentCourseRateUpdateEvent({required this.rate});
}
