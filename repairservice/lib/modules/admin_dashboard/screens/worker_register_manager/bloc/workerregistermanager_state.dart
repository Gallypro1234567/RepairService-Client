part of 'workerregistermanager_bloc.dart';

enum WorkerregistermanagerStatus { loading, success, failure, submitted }

class WorkerregistermanagerState extends Equatable {
  const WorkerregistermanagerState(
      {this.status,
      this.workerregister,
      this.formIsApproval,
      this.workerOfServicesCode});

  final WorkerregistermanagerStatus status;
  final List<WorkerRegister> workerregister;
  final int formIsApproval;
  final String workerOfServicesCode;
  @override
  List<Object> get props =>
      [status, workerregister, formIsApproval, workerOfServicesCode];

  WorkerregistermanagerState copyWith(
      {WorkerregistermanagerStatus status,
      int formIsApproval,
      String workerOfServicesCode,
      List<WorkerRegister> workerregister}) {
    return WorkerregistermanagerState(
        status: status ?? this.status,
        formIsApproval: formIsApproval ?? this.formIsApproval,
        workerOfServicesCode: workerOfServicesCode ?? this.workerOfServicesCode,
        workerregister: workerregister ?? this.workerregister);
  }
}
