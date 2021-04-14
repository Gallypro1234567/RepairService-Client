import 'package:formz/formz.dart';

enum NewPasswordValidationError { empty }

class NewPassword extends FormzInput<String, NewPasswordValidationError> {
  const NewPassword.pure() : super.pure('');
  const NewPassword.dirty([String value = '']) : super.dirty(value);

  @override
  NewPasswordValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : NewPasswordValidationError.empty;
  }
}
