part of 'workerregistermanager_bloc.dart';

enum WorkerregistermanagerStatus { loading, success, failure, submitted }

class WorkerregistermanagerState extends Equatable {
  const WorkerregistermanagerState(
      {this.status,
      this.workerregister,
      this.formIsApproval,
      this.workerOfServicesCode,
      this.changed = false});

  final WorkerregistermanagerStatus status;
  final List<WorkerRegister> workerregister;
  final int formIsApproval;
  final String workerOfServicesCode;
  final bool changed;
  @override
  List<Object> get props =>
      [status, workerregister, formIsApproval, workerOfServicesCode, changed];

  WorkerregistermanagerState copyWith(
      {WorkerregistermanagerStatus status,
      int formIsApproval,
      String workerOfServicesCode,
      List<WorkerRegister> workerregister,
      bool changed}) {
    return WorkerregistermanagerState(
        status: status ?? this.status,
        formIsApproval: formIsApproval ?? this.formIsApproval,
        workerOfServicesCode: workerOfServicesCode ?? this.workerOfServicesCode,
        workerregister: workerregister ?? this.workerregister,
        changed: changed ?? this.changed);
  }
}
