part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesStateLoading extends CoursesState {}

class CoursesStateEmpty extends CoursesStateLoadSuccess {
  CoursesStateEmpty()
      : super(
          courses: [],
          hasMoreData: false,
        );
}

class CoursesStateActionLoading extends CoursesStateLoadSuccess {
  CoursesStateActionLoading({required CoursesStateLoadSuccess currentState})
      : super(
          courses: currentState.courses,
          currentCourse: currentState.currentCourse,
          hasMoreData: currentState.hasMoreData,
        );
}

class CoursesStateLoadSuccess extends CoursesState {
  final List<Course> courses;
  final bool hasMoreData;

  final Course currentCourse;
  final bool owner;
  final bool joined;

  static const emptyCourse = Course('', '', '', '', '', false, 0, 0);

  const CoursesStateLoadSuccess({
    required this.courses,
    required this.hasMoreData,
    Course? currentCourse,
  })  : currentCourse = currentCourse ?? emptyCourse,
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

  String getCourseRateString(int index) {
    if (courses[index].getRate() != 0)
      return courses[index].getRate().toStringAsFixed(1) +
          kCourseRateMax +
          ' (${courses[index].ratesNumber})';
    else
      return kNoRatesYet;
  }

  String getCurrentCourseRateString() {
    if (currentCourse.getRate() != 0)
      return currentCourse.getRate().toStringAsFixed(1) +
          kCourseRateMax +
          ' (${currentCourse.ratesNumber})';
    else
      return kNoRatesYet;
  }

  @override
  List<Object> get props => [courses, currentCourse, owner, joined];
}
