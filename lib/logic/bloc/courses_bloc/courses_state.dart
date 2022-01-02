part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesStateLoading extends CoursesState {}

class CoursesStateEmpty extends CoursesState {}

class CoursesStateLoadSuccess extends CoursesState {
  final List<Course> courses;
  final bool hasMoreData;

  const CoursesStateLoadSuccess(this.courses, this.hasMoreData);

  @override
  List<Object> get props => [courses];
}
