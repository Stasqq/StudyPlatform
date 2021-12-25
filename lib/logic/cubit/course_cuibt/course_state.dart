part of 'course_cubit.dart';

enum CourseNameValidationError { invalid }

class CourseState extends Equatable {
  const CourseState({
    this.id,
    this.ownerUid,
    this.courseName = const CourseName.pure(),
    this.description,
    this.classes,
    this.public = true,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final String? id;
  final String? ownerUid;
  final CourseName courseName;
  final String? description;
  final List<Class>? classes;
  final bool public;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [id, ownerUid, courseName, description, classes, public, status];

  CourseState copyWith({
    String? id,
    String? ownerUid,
    CourseName? courseName,
    String? description,
    List<Class>? classes,
    bool? public,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return CourseState(
      id: id ?? this.id,
      ownerUid: ownerUid ?? this.ownerUid,
      courseName: courseName ?? this.courseName,
      description: description ?? this.description,
      classes: classes ?? this.classes,
      public: public ?? this.public,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
