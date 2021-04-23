part of 'workerregistermanager_bloc.dart';

abstract class WorkerregistermanagerEvent extends Equatable {
  const WorkerregistermanagerEvent();

  @override
  List<Object> get props => [];
}

class WorkerregistermanagerFetched extends WorkerregistermanagerEvent {}

class WorkerregistermanagerStatusChanged extends WorkerregistermanagerEvent {
  final String value;
  final String text;

  WorkerregistermanagerStatusChanged(this.value, this.text);
}

class WorkerregistermanagerSubmit extends WorkerregistermanagerEvent {}
 