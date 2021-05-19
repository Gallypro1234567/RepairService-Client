part of 'servicemanager_bloc.dart';

abstract class ServicemanagerEvent extends Equatable {
  const ServicemanagerEvent();

  @override
  List<Object> get props => [];
}

class ServicemanagerInitial extends ServicemanagerEvent {}

class ServicemanagerFetched extends ServicemanagerEvent {}
class ServicemanagerNew extends ServicemanagerEvent {}

class ServicemanagerEventSubmited extends ServicemanagerEvent {}

class ServicemanagerNameChanged extends ServicemanagerEvent {
  final String name;

  ServicemanagerNameChanged(this.name);
}

class ServicemanagerDesciptionChanged extends ServicemanagerEvent {
  final String description;

  ServicemanagerDesciptionChanged(this.description);
}

class ServiceManagerDeleteSubmited extends ServicemanagerEvent {
  final String code;

  ServiceManagerDeleteSubmited(this.code);
}

class ServicemanagerImageChanged extends ServicemanagerEvent {
  final ImageSource imageSource;

  ServicemanagerImageChanged(this.imageSource);
}
