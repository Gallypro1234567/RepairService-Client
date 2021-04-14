import 'package:formz/formz.dart';

enum OldPasswordValidationError { empty }

class OldPassword extends FormzInput<String, OldPasswordValidationError> {
  const OldPassword.pure() : super.pure('');
  const OldPassword.dirty([String value = '']) : super.dirty(value);

  @override
  OldPasswordValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : OldPasswordValidationError.empty;
  }
}
