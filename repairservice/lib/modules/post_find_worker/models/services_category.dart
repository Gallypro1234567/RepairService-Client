import 'package:formz/formz.dart';

enum ServiceCategoryValidationError { empty }

class ServiceCategory extends FormzInput<String, ServiceCategoryValidationError> {
  const ServiceCategory.pure() : super.pure('');
  const ServiceCategory.dirty([String value = '']) : super.dirty(value);

  @override
  ServiceCategoryValidationError validator(String value) {
     return value?.isNotEmpty == true ? null : ServiceCategoryValidationError.empty;
  }
}
