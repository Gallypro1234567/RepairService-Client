import 'package:formz/formz.dart';

enum VerifyPasswordValidationError { empty }

class VerifyPassword extends FormzInput<String, VerifyPasswordValidationError> {
  const VerifyPassword.pure() : super.pure('');
  const VerifyPassword.dirty([String value = '']) : super.dirty(value);

  @override
  VerifyPasswordValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : VerifyPasswordValidationError.empty;
  }
}
