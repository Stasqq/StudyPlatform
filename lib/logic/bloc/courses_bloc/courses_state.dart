part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesStateLoading extends CoursesState {}

class CoursesStateEmpty extends CoursesStateLoadSuccess {
  CoursesStateEmpty() : super(courses: [], hasMoreData: false);
}

class CoursesStateLoadSuccess extends CoursesState {
  final List<Course> courses;
  final bool hasMoreData;

  final Course currentCourse;
  final bool owner;
  final bool joined;

  static const emptyCourse = Course('', '', '', '', '', false);

  const CoursesStateLoadSuccess({
    required this.courses,
    required this.hasMoreData,
  })  : currentCourse = emptyCourse,
        owner = false,
        joined = false;

  const CoursesStateLoadSuccess.forCopy({
    required this.courses,
    required this.hasMoreData,
    required this.currentCourse,
    required this.joined,
    required this.owner,
  });

  CoursesStateLoadSuccess copyWith(
      {List<Course>? courses,
      bool? hasMoreData,
      Course? currentCourse,
      bool? owner,
      bool? joined}) {
    return CoursesStateLoadSuccess.forCopy(
        courses: courses ?? this.courses,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        currentCourse: currentCourse ?? this.currentCourse,
        owner: owner ?? this.owner,
        joined: joined ?? this.joined);
  }

  @override
  List<Object> get props => [courses, currentCourse, owner, joined];
}
