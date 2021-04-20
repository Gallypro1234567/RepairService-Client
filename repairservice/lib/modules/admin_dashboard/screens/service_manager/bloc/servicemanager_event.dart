part of 'servicemanager_bloc.dart';

abstract class ServicemanagerEvent extends Equatable {
  const ServicemanagerEvent();

  @override
  List<Object> get props => [];
}

class ServicemanagerInitial extends ServicemanagerEvent {}

class ServicemanagerEventSubmited extends ServicemanagerEvent {}

class ServicemanagerNameChanged extends ServicemanagerEvent {
  final String name;

  ServicemanagerNameChanged(this.name);
}

class ServicemanagerDesciptionChanged extends ServicemanagerEvent {
  final String description;

  ServicemanagerDesciptionChanged(this.description);
}

class ServicemanagerImageChanged extends ServicemanagerEvent {
  final File file;

  ServicemanagerImageChanged(this.file);
}
