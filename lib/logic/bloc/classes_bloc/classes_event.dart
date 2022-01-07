part of 'classes_bloc.dart';

abstract class ClassesEvent extends Equatable {
  const ClassesEvent();

  @override
  List<Object> get props => [];
}

class ClassesEventStart extends ClassesEvent {
  const ClassesEventStart({required this.courseId});

  final String courseId;

  @override
  List<Object> get props => [courseId];
}

class ClassesEventLoad extends ClassesEvent {
  final List<List<Class>> classes;

  const ClassesEventLoad(this.classes);

  @override
  List<Object> get props => [classes];
}

class ClassesEventFetchMore extends ClassesEvent {}

class CurrentClassEvent extends ClassesEvent {
  final Class currentClass;

  CurrentClassEvent({required this.currentClass});

  @override
  List<Object> get props => [currentClass];
}

class ClassCreateEvent extends ClassesEvent {
  final String name;
  final String description;
  final int index;

  ClassCreateEvent(
      {required this.name, required this.description, required this.index});
}

class CurrentClassDeleteEvent extends ClassesEvent {}

class CurrentClassMaterialAddEvent extends ClassesEvent {}

class CurrentClassMaterialDeleteEvent extends ClassesEvent {
  final String fileName;

  CurrentClassMaterialDeleteEvent({required this.fileName});
}

class CurrentClassMaterialDownloadEvent extends ClassesEvent {
  final String fileName;

  CurrentClassMaterialDownloadEvent(this.fileName);
}
