part of 'workerregisterwork_bloc.dart';

abstract class WorkerregisterworkEvent extends Equatable {
  const WorkerregisterworkEvent();

  @override
  List<Object> get props => [];
}

class WorkerregisterworkInitial extends WorkerregisterworkEvent {}

class WorkerregisterworkNew extends WorkerregisterworkEvent {}

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

class WorkerregisterworkImageAfterChanged extends WorkerregisterworkEvent {
  final ImageSource imageSource;
  WorkerregisterworkImageAfterChanged(this.imageSource);
}

class WorkerregisterworkAfterDeleteImage extends WorkerregisterworkEvent {
 
}
class WorkerregisterworkBeforeDeleteImage extends WorkerregisterworkEvent {
 
}
class WorkerregisterworkImageBeforeChanged extends WorkerregisterworkEvent {
  final ImageSource imageSource;
  WorkerregisterworkImageBeforeChanged(this.imageSource);
}
 
class WorkerregisterworkSubmitted extends WorkerregisterworkEvent {}
