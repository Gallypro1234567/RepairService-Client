part of 'workerregisterwork_bloc.dart';

enum WorkerRegisterStatus {
  none,
  loading,
  success,
  failure,
  registerSuccessed,
  loadSuccessed
}

class WorkerregisterworkState extends Equatable {
  const WorkerregisterworkState(
      {this.status = WorkerRegisterStatus.none,
      this.cmnd,
      this.imageCMND,
      this.services,
      this.workerofserviceOfworkerBytoken,
      this.serviceText,
      this.serviceCode});

  final WorkerRegisterStatus status;
  final String cmnd;
  final File imageCMND;
  final List<Service> services;
  final List<Service> workerofserviceOfworkerBytoken;
  final String serviceCode;
  final String serviceText;
  @override
  List<Object> get props => [
        status,
        cmnd,
        imageCMND,
        services,
        workerofserviceOfworkerBytoken,
        serviceCode,
        serviceText
      ];

  WorkerregisterworkState copyWith(
      {WorkerRegisterStatus status,
      String cmnd,
      File imageCMND,
      String serviceText,
      List<Service> services,
      List<Service> workerofserviceOfworkerBytoken,
      String serviceCode}) {
    return WorkerregisterworkState(
        status: status ?? this.status,
        cmnd: cmnd ?? this.cmnd,
        imageCMND: imageCMND ?? this.imageCMND,
        services: services ?? this.services,
        workerofserviceOfworkerBytoken: workerofserviceOfworkerBytoken ??
            this.workerofserviceOfworkerBytoken,
        serviceText: serviceText ?? this.serviceText,
        serviceCode: serviceCode ?? serviceCode);
  }
}
