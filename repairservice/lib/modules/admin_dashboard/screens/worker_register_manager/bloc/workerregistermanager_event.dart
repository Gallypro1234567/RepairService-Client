part of 'workerregistermanager_bloc.dart';

abstract class WorkerregistermanagerEvent extends Equatable {
  const WorkerregistermanagerEvent();

  @override
  List<Object> get props => [];
}

class WorkerregistermanagerFetched extends WorkerregistermanagerEvent {}

class WorkerregistermanagerFetchedDetail extends WorkerregistermanagerEvent {
  final int isApproval;
  final String code;

  WorkerregistermanagerFetchedDetail({this.isApproval, this.code});
}

class WorkerregistermanagerStatusChanged extends WorkerregistermanagerEvent {
  final String value;
  final String text;

  WorkerregistermanagerStatusChanged(this.value, this.text);
}

class WorkerregistermanagerSubmit extends WorkerregistermanagerEvent {}

class WorkerregistermanagerApprovalChanged extends WorkerregistermanagerEvent {
  final int value;

  WorkerregistermanagerApprovalChanged(this.value);
}

class WorkerregistermanagerCode extends WorkerregistermanagerEvent {
  final String value;

  WorkerregistermanagerCode(this.value);
}
