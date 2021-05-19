part of 'workerregisterwork_bloc.dart';

enum WorkerRegisterStatus {
  none,
  loading,
  success,
  failure,
  registerSuccessed,
  loadSuccessed,
  exitFailure
}
enum FileStatus { open, close }

class WorkerregisterworkState extends Equatable {
  const WorkerregisterworkState(
      {this.status = WorkerRegisterStatus.none,
      this.imageCMNDBefore,
      this.imageCMNDAfter,
      this.imageAfterInvalid = true,
      this.imageBeforeInvalid = true,
      this.serviceRegisters,
      this.workerofserviceOfworkerBytoken,
      this.serviceText,
      this.serviceCode});

  final WorkerRegisterStatus status;

  final File imageCMNDBefore;
  final File imageCMNDAfter;
  final bool imageAfterInvalid;
  final bool imageBeforeInvalid;

  final List<WorkerRegister> serviceRegisters;
  final List<Service> workerofserviceOfworkerBytoken;
  final String serviceCode;
  final String serviceText;

  @override
  List<Object> get props => [
        status,
        imageCMNDBefore,
        imageCMNDAfter,
        imageAfterInvalid,
        imageBeforeInvalid,
        serviceRegisters,
        workerofserviceOfworkerBytoken,
        serviceCode,
        serviceText
      ];

  WorkerregisterworkState copyWith(
      {WorkerRegisterStatus status,
      File imageCMNDBefore,
      File imageCMNDAfter,
      bool imageAfterInvalid,
      bool imageBeforeInvalid,
      String serviceText,
      List<WorkerRegister> serviceRegisters,
      List<Service> workerofserviceOfworkerBytoken,
      String serviceCode}) {
    return WorkerregisterworkState(
        status: status ?? this.status,
        imageCMNDBefore: imageCMNDBefore ?? this.imageCMNDBefore,
        imageCMNDAfter: imageCMNDAfter ?? this.imageCMNDAfter,
        imageAfterInvalid: imageAfterInvalid ?? this.imageAfterInvalid,
        imageBeforeInvalid: imageBeforeInvalid ?? this.imageBeforeInvalid,
        serviceRegisters: serviceRegisters ?? this.serviceRegisters,
        workerofserviceOfworkerBytoken: workerofserviceOfworkerBytoken ??
            this.workerofserviceOfworkerBytoken,
        serviceText: serviceText ?? this.serviceText,
        serviceCode: serviceCode ?? serviceCode);
  }
}
