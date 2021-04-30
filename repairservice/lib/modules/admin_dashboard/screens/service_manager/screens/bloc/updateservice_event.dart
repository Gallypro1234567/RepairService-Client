part of 'updateservice_bloc.dart';

abstract class UpdateserviceEvent extends Equatable {
  const UpdateserviceEvent();

  @override
  List<Object> get props => [];
}

class UpdateserviceInitial extends UpdateserviceEvent {}

class UpdateserviceFetched extends UpdateserviceEvent {
  final String code;

  UpdateserviceFetched(this.code);
}

class UpdateserviceNameChanged extends UpdateserviceEvent {
  final String value;

  UpdateserviceNameChanged(this.value);
}

class UpdateserviceDescriptionChanged extends UpdateserviceEvent {
  final String value;

  UpdateserviceDescriptionChanged(this.value);
}

class UpdateserviceImageChanged extends UpdateserviceEvent {
  final ImageSource imageSource;
  UpdateserviceImageChanged(this.imageSource);
}

class UpdateserviceSubmited extends UpdateserviceEvent {}
