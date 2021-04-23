import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/modules/worker_history_work/models/cmnd.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';

part 'workerregisterwork_event.dart';
part 'workerregisterwork_state.dart';

class WorkerregisterworkBloc
    extends Bloc<WorkerregisterworkEvent, WorkerregisterworkState> {
  WorkerregisterworkBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(WorkerregisterworkState());
  final UserRepository _userRepository;
  @override
  Stream<WorkerregisterworkState> mapEventToState(
    WorkerregisterworkEvent event,
  ) async* {
    if (event is WorkerregisterworkInitial) {
      yield state.copyWith();
    } else if (event is WorkerregisterworkCMNDChanged) {
      yield state.copyWith(cmnd: event.value);
    } else if (event is WorkerregisterworkServiceChanged) {
      yield state.copyWith(serviceCode: event.value, serviceText: event.text);
    } else if (event is WorkerregisterworkSubmitted) {
      yield* _mapWorkerregisterworkSubmittedToState(event, state);
    } else if (event is WorkerregisterworkServiceRegisterLoad) {
      yield* _mapWorkerregisterworkServiceRegisterLoadToState(event, state);
    }
  }

  Stream<WorkerregisterworkState> _mapWorkerregisterworkSubmittedToState(
      WorkerregisterworkSubmitted event, WorkerregisterworkState state) async* {
    yield state.copyWith(status: WorkerRegisterStatus.loading);
    try {
      var response = await _userRepository.workerRegisterService(
        file: state.imageCMND,
        serviceCode: state.serviceCode,
      );
      if (response.statusCode == 200) {
        yield state.copyWith(status: WorkerRegisterStatus.registerSuccessed);
      } else {
        yield state.copyWith(status: WorkerRegisterStatus.exitFailure);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: WorkerRegisterStatus.failure);
    }
  }

  Stream<WorkerregisterworkState>
      _mapWorkerregisterworkServiceRegisterLoadToState(
          WorkerregisterworkServiceRegisterLoad event,
          WorkerregisterworkState state) async* {
    yield state.copyWith(status: WorkerRegisterStatus.loading);
    try {
      var serviceList = await _userRepository.fetchWorkerOfServiceByCode(
        serviceCode: state.serviceCode,
      );
      yield state.copyWith(
          status: WorkerRegisterStatus.loadSuccessed, services: serviceList);
    } on Exception catch (_) {
      yield state.copyWith(status: WorkerRegisterStatus.failure);
    }
  }
}
