import 'package:formz/formz.dart';

enum CMNDValidationError { empty }

class CMND extends FormzInput<String, CMNDValidationError> {
  const CMND.pure() : super.pure('');
  const CMND.dirty([String value = '']) : super.dirty(value);

  @override
  CMNDValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : CMNDValidationError.empty;
  }
}
