part of 'workerregisterwork_bloc.dart';

abstract class WorkerregisterworkEvent extends Equatable {
  const WorkerregisterworkEvent();

  @override
  List<Object> get props => [];
}

class WorkerregisterworkInitial extends WorkerregisterworkEvent {}

class WorkerregisterworkServiceRegisterLoad extends WorkerregisterworkEvent {}
class WorkerregisterworkServiceChanged extends WorkerregisterworkEvent {
  final String value;
  final String text;
  WorkerregisterworkServiceChanged({this.value, this.text});
}

class WorkerregisterworkCMNDChanged extends WorkerregisterworkEvent {
  final String value;

  WorkerregisterworkCMNDChanged(this.value);
}

class WorkerregisterworkFileChanged extends WorkerregisterworkEvent {
  final String value;

  WorkerregisterworkFileChanged(this.value);
}

class WorkerregisterworkImageUrlChanged extends WorkerregisterworkEvent {
  final File file;

  WorkerregisterworkImageUrlChanged(this.file);
}

class WorkerregisterworkSubmitted extends WorkerregisterworkEvent {}
