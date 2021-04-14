import 'package:formz/formz.dart';

enum PasswordVerifyRegisterValidationError { empty }

class PasswordVerifyRegister
    extends FormzInput<String, PasswordVerifyRegisterValidationError> {
  const PasswordVerifyRegister.pure() : super.pure('');
  const PasswordVerifyRegister.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordVerifyRegisterValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : PasswordVerifyRegisterValidationError.empty;
  }
}
