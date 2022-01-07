import 'package:formz/formz.dart';

enum CourseNameValidationError { invalid }

class CourseName extends FormzInput<String, CourseNameValidationError> {
  const CourseName.pure() : super.pure('');

  const CourseName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _courseNameRegExp = RegExp(
    r'\b[a-zA-Z0-9 ._%+-]{4,30}\b',
  );

  @override
  CourseNameValidationError? validator(String? value) {
    return _courseNameRegExp.hasMatch(value ?? '')
        ? null
        : CourseNameValidationError.invalid;
  }
}
