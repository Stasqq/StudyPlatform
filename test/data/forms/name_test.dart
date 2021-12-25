import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/data/forms/name_form.dart';

void main() {
  group('name form', () {
    test('accept correct name', () {
      Name name = Name.pure();
      expect(name.validator('Value'), null);
    });

    test('error - begin with small letter', () {
      Name name = Name.pure();
      expect(name.validator('value'), NameValidationError.invalid);
    });

    test('error - big letter inside', () {
      Name name = Name.pure();
      expect(name.validator('VaLue'), NameValidationError.invalid);
    });

    test('error - too long', () {
      Name name = Name.pure();
      expect(name.validator('Valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'),
          NameValidationError.invalid);
    });
  });
}
