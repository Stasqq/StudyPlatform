part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class CoursesEventStart extends CoursesEvent {}

class CoursesEventLoad extends CoursesEvent {
  final List<List<Course>> courses;

  const CoursesEventLoad(this.courses);

  @override
  List<Object> get props => [courses];
}

class CoursesEventFetchMore extends CoursesEvent {}
