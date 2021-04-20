part of 'servicemanager_bloc.dart';

enum ServiceManagerStatus { none, loading, success, failure }

class ServicemanagerState extends Equatable {
  const ServicemanagerState(
      {this.status = ServiceManagerStatus.none,
      this.name = "",
      this.description = "",
      this.image,
      this.statusCode = 400});

  final ServiceManagerStatus status;
  final String name;
  final String description;
  final File image;
  final int statusCode;
  @override
  List<Object> get props => [status, statusCode, name, description, image];

  ServicemanagerState copyWith({
    ServiceManagerStatus status,
    String name,
    String description,
    File image,
    int statusCode,
  }) {
    return ServicemanagerState(
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
