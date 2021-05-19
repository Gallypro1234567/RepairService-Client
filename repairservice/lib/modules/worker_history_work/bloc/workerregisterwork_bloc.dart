import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
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
    if (event is WorkerregisterworkInitial)
      yield state.copyWith();
    else if (event is WorkerregisterworkNew)
      yield state.copyWith(
        serviceCode: "",
        serviceText: "",
      );
    else if (event is WorkerregisterworkImageAfterChanged)
      yield* _mapWorkerregisterworkImageAfterChangedToState(event, state);
    else if (event is WorkerregisterworkImageBeforeChanged)
      yield* _mapWorkerregisterworkImageBeforeChangedToState(event, state);
    else if (event is WorkerregisterworkAfterDeleteImage)
      yield state.copyWith(imageAfterInvalid: true);
    else if (event is WorkerregisterworkBeforeDeleteImage)
      yield state.copyWith(imageBeforeInvalid: true);
    else if (event is WorkerregisterworkServiceChanged)
      yield state.copyWith(serviceCode: event.value, serviceText: event.text);
    else if (event is WorkerregisterworkSubmitted)
      yield* _mapWorkerregisterworkSubmittedToState(event, state);
    else if (event is WorkerregisterworkServiceRegisterLoad)
      yield* _mapWorkerregisterworkServiceRegisterLoadToState(event, state);
  }

  Stream<WorkerregisterworkState>
      _mapWorkerregisterworkImageAfterChangedToState(
          WorkerregisterworkImageAfterChanged event,
          WorkerregisterworkState state) async* {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: event.imageSource);
      if (pickedFile != null) {
        yield state.copyWith(
            imageCMNDAfter: new File(pickedFile.path),
            imageAfterInvalid: false);
      } else {
        yield state.copyWith(
            imageCMNDAfter: state.imageCMNDAfter, imageAfterInvalid: true);
      }
    } on Exception catch (_) {}
  }

  Stream<WorkerregisterworkState>
      _mapWorkerregisterworkImageBeforeChangedToState(
          WorkerregisterworkImageBeforeChanged event,
          WorkerregisterworkState state) async* {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: event.imageSource);
      if (pickedFile != null) {
        yield state.copyWith(
            imageCMNDBefore: new File(pickedFile.path),
            imageBeforeInvalid: false);
      } else {
        yield state.copyWith(
            imageCMNDBefore: state.imageCMNDAfter, imageBeforeInvalid: true);
      }
    } on Exception catch (_) {}
  }

  Stream<WorkerregisterworkState> _mapWorkerregisterworkSubmittedToState(
      WorkerregisterworkSubmitted event, WorkerregisterworkState state) async* {
    yield state.copyWith(status: WorkerRegisterStatus.loading);
    try {
      List<File> list = [];
      if (!state.imageAfterInvalid && !state.imageBeforeInvalid) {
        list.add(state.imageCMNDAfter);
        list.add(state.imageCMNDBefore);
      }

      var response = await _userRepository.workerRegisterService(
        files: list,
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
      var serviceList = await _userRepository.fetchWorkerRegisterByUser();
      yield state.copyWith(
          status: WorkerRegisterStatus.loadSuccessed,
          serviceRegisters: serviceList);
    } on Exception catch (_) {
      yield state.copyWith(status: WorkerRegisterStatus.failure);
    }
  }
}
