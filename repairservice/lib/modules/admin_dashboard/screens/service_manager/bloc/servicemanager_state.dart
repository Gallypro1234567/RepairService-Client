part of 'servicemanager_bloc.dart';

enum ServiceManagerStatus { loading, success, failure }

class ServicemanagerState extends Equatable {
  const ServicemanagerState(
      {this.status = ServiceManagerStatus.loading,
      this.formzStatus = FormzStatus.pure,
      this.servicename = const ServiceFormz.pure(),
      this.description = const DescriptionFormz.pure(),
      this.image,
      this.imageInvalid = true,
      this.statusCode = 400,
      this.services});

  final ServiceManagerStatus status;
  final FormzStatus formzStatus;
  final ServiceFormz servicename;
  final DescriptionFormz description;
  final File image;
  final bool imageInvalid;
  final int statusCode;
  final List<Service> services;

  @override
  List<Object> get props => [
        status,
        formzStatus,
        statusCode,
        servicename,
        description,
        image,
        services,
        imageInvalid
      ];

  ServicemanagerState copyWith(
      {ServiceManagerStatus status,
      FormzStatus formzStatus,
      ServiceFormz servicename,
      DescriptionFormz description,
      File image,
      bool imageInvalid,
      int statusCode,
      List<Service> services}) {
    return ServicemanagerState(
        status: status ?? this.status,
        formzStatus: formzStatus ?? this.formzStatus,
        servicename: servicename ?? this.servicename,
        imageInvalid: imageInvalid ?? this.imageInvalid,
        description: description ?? this.description,
        image: image ?? this.image,
        statusCode: statusCode ?? this.statusCode,
        services: services ?? this.services);
  }
}

enum ServiceFormzValidationError { empty }

class ServiceFormz extends FormzInput<String, ServiceFormzValidationError> {
  const ServiceFormz.pure() : super.pure('');
  const ServiceFormz.dirty([String value = '']) : super.dirty(value);

  @override
  ServiceFormzValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : ServiceFormzValidationError.empty;
  }
}

enum DescriptionFormzValidationError { empty }

class DescriptionFormz
    extends FormzInput<String, DescriptionFormzValidationError> {
  const DescriptionFormz.pure() : super.pure('');
  const DescriptionFormz.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionFormzValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : DescriptionFormzValidationError.empty;
  }
}
