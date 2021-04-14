import 'package:formz/formz.dart';

enum PhoneRegisterValidationError { empty }

class PhoneRegister extends FormzInput<String, PhoneRegisterValidationError> {
  const PhoneRegister.pure() : super.pure('');
  const PhoneRegister.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneRegisterValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : PhoneRegisterValidationError.empty;
  }
}
