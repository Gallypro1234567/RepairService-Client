import 'package:formz/formz.dart';

enum FullnameRegisterValidationError { empty }

class FullnameRegister extends FormzInput<String, FullnameRegisterValidationError> {
  const FullnameRegister.pure() : super.pure('');
  const FullnameRegister.dirty([String value = '']) : super.dirty(value);

  @override
  FullnameRegisterValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : FullnameRegisterValidationError.empty;
  }
}
