part of 'workerregistermanager_bloc.dart';

enum WorkerregistermanagerStatus { loading, success, failure }

class WorkerregistermanagerState extends Equatable {
  const WorkerregistermanagerState({this.status, this.workerregister});

  final WorkerregistermanagerStatus status;
  final List<WorkerRegister> workerregister;

  @override
  List<Object> get props => [status, workerregister];

  WorkerregistermanagerState copyWith(
      {WorkerregistermanagerStatus status,
      List<WorkerRegister> workerregister}) {
    return WorkerregistermanagerState(
        status: status ?? this.status,
        workerregister: workerregister ?? this.workerregister);
  }
}
