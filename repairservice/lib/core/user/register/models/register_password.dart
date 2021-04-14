import 'package:formz/formz.dart';

enum PasswordRegisterValidationError { empty }

class PasswordRegister extends FormzInput<String, PasswordRegisterValidationError> {
  const PasswordRegister.pure() : super.pure('');
  const PasswordRegister.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordRegisterValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : PasswordRegisterValidationError.empty;
  }
}
