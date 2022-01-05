part of 'classes_bloc.dart';

abstract class ClassesState extends Equatable {
  ClassesState({required this.courseId});

  late String courseId;

  @override
  List<Object> get props => [];
}

class ClassesStateLoading extends ClassesState {
  ClassesStateLoading() : super(courseId: '');
}

class ClassesStateEmpty extends ClassesStateLoadSuccess {
  ClassesStateEmpty({required String courseId, Class? currentClass})
      : super(classes: [], hasMoreData: false, courseId: courseId);
}

class ClassesStateActionLoading extends ClassesStateLoadSuccess {
  ClassesStateActionLoading({required ClassesStateLoadSuccess currentState})
      : super(
            courseId: currentState.courseId,
            classes: currentState.classes,
            hasMoreData: currentState.hasMoreData);
}

class ClassesStateLoadSuccess extends ClassesState {
  final List<Class> classes;
  final bool hasMoreData;

  final Class currentClass;

  static const emptyClass = Class('', 0, '', '', <String>[]);

  ClassesStateLoadSuccess({
    required String courseId,
    required this.classes,
    required this.hasMoreData,
  })  : currentClass = emptyClass,
        super(courseId: courseId);

  ClassesStateLoadSuccess.forCopy(
      {required this.classes,
      required this.hasMoreData,
      required this.currentClass,
      required String courseId})
      : super(courseId: courseId);

  ClassesStateLoadSuccess copyWith({
    List<Class>? classes,
    bool? hasMoreData,
    Class? currentClass,
    String? courseId,
  }) {
    return ClassesStateLoadSuccess.forCopy(
      classes: classes ?? this.classes,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentClass: currentClass ?? this.currentClass,
      courseId: courseId ?? this.courseId,
    );
  }

  @override
  List<Object> get props => [classes, currentClass, courseId, hasMoreData];
}
