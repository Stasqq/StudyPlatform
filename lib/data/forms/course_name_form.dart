import 'package:formz/formz.dart';

/// Validation errors for the [Name] [FormzInput].
enum CourseNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Name}
/// Form input for an Name input.
/// {@endtemplate}
class CourseName extends FormzInput<String, CourseNameValidationError> {
  /// {@macro Surname}
  const CourseName.pure() : super.pure('');

  /// {@macro Surname}
  const CourseName.dirty([String value = '']) : super.dirty(value);

  /// between 4 and 30 characters, alphanumeric and some marks
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
