part of 'course_cubit.dart';

enum CourseNameValidationError { invalid }

class CourseState extends Equatable {
  const CourseState({
    this.id,
    this.ownerUid,
    this.ownerName,
    this.courseName = const CourseName.pure(),
    this.description,
    this.classes,
    this.public = true,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final String? id;
  final String? ownerUid;
  final String? ownerName;
  final CourseName courseName;
  final String? description;
  final List<Class>? classes;
  final bool public;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        id,
        ownerUid,
        ownerName,
        courseName,
        description,
        classes,
        public,
        status
      ];

  bool isDescriptionValid() {
    if (description != null) {
      return description!.length < 400;
    }
    return true;
  }

  CourseState copyWith({
    String? id,
    String? ownerUid,
    String? ownerName,
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
      ownerName: ownerName ?? this.ownerName,
      courseName: courseName ?? this.courseName,
      description: description ?? this.description,
      classes: classes ?? this.classes,
      public: public ?? this.public,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
