part of 'preferentialmanager_bloc.dart';

abstract class PreferentialmanagerEvent extends Equatable {
  const PreferentialmanagerEvent();

  @override
  List<Object> get props => [];
}

class PreferentialmanagerInitial extends PreferentialmanagerEvent {}

class PreferentialmanagerTitleChanged extends PreferentialmanagerEvent {
  final String value;

  PreferentialmanagerTitleChanged(this.value);
}

class PreferentialmanagerDescriptionChanged extends PreferentialmanagerEvent {
  final String value;

  PreferentialmanagerDescriptionChanged(this.value);
}

class PreferentialmanagerFromDateChanged extends PreferentialmanagerEvent {
  final String value;

  PreferentialmanagerFromDateChanged(this.value);
}

class PreferentialmanagerToDateChanged extends PreferentialmanagerEvent {
  final String value;

  PreferentialmanagerToDateChanged(this.value);
}

class PreferentialmanagerPercentChanged extends PreferentialmanagerEvent {
  final String value;

  PreferentialmanagerPercentChanged(this.value);
}

class PreferentialmanagerImageChanged extends PreferentialmanagerEvent {
  final File file;

  PreferentialmanagerImageChanged(this.file);
}

class PreferentialmanagerSubmitted extends PreferentialmanagerEvent {}
