import 'package:formz/formz.dart';

/// Validation errors for the [Name] [FormzInput].
enum NameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Name}
/// Form input for an Name input.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError> {
  /// {@macro Name}
  const Name.pure() : super.pure('');

  /// {@macro Name}
  const Name.dirty([String value = '']) : super.dirty(value);

  /// starts with upper case letter, later only lower case, between 3 to 20 letters
  static final RegExp _nameRegExp = RegExp(
    r'\b[A-Z]{1}[a-z]{2,19}\b',
  );

  @override
  NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '') ? null : NameValidationError.invalid;
  }
}
