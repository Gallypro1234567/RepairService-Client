import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/modules/post/models/description.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';

import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';

part 'servicemanager_event.dart';
part 'servicemanager_state.dart';

class ServicemanagerBloc
    extends Bloc<ServicemanagerEvent, ServicemanagerState> {
  ServicemanagerBloc({DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(ServicemanagerState());
  final DashboardRepository _dashboardRepository;
  @override
  Stream<ServicemanagerState> mapEventToState(
    ServicemanagerEvent event,
  ) async* {
    if (event is ServicemanagerInitial)
      yield state.copyWith();
    else if (event is ServicemanagerFetched)
      yield* _mapServicemanagerInitialToState(event, state);
    else if (event is ServicemanagerNew)
      yield state.copyWith(
          imageInvalid: true,
          description: DescriptionFormz.pure(),
          servicename: ServiceFormz.pure(),
          formzStatus: Formz.validate([state.description, state.servicename]));
    else if (event is ServicemanagerNameChanged)
      yield _mapServicemanagerNameChangedToState(event, state);
    else if (event is ServicemanagerDesciptionChanged)
      yield _mapServicemanagerDesciptionChangedToState(event, state);
    else if (event is ServicemanagerImageChanged)
      yield* _mapServicemanagerImageChangedToState(event, state);
    else if (event is ServicemanagerEventSubmited)
      yield* _mapServicemanagerEventSubmitedToState(event, state);
    else if (event is ServiceManagerDeleteSubmited)
      yield* _mapServicemanagerDeleteSubmitedToState(event, state);
  }

  Stream<ServicemanagerState> _mapServicemanagerEventSubmitedToState(
      ServicemanagerEventSubmited event, ServicemanagerState state) async* {
    yield state.copyWith(status: ServiceManagerStatus.loading);
    try {
      var response = await _dashboardRepository.addService(
          name: state.servicename.value,
          description: state.description.value,
          file: state.image);
      if (response.statusCode == 200) {
        yield state.copyWith(
            status: ServiceManagerStatus.success,
            statusCode: 200,
            formzStatus: FormzStatus.submissionSuccess);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: ServiceManagerStatus.failure);
    }
  }

  Stream<ServicemanagerState> _mapServicemanagerInitialToState(
      ServicemanagerFetched event, ServicemanagerState state) async* {
    yield state.copyWith(status: ServiceManagerStatus.loading);
    try {
      var services = await _dashboardRepository.fetchService();

      yield state.copyWith(
          status: ServiceManagerStatus.success,
          statusCode: 200,
          services: services,
          formzStatus: FormzStatus.pure);
    } on Exception catch (_) {
      yield state.copyWith(status: ServiceManagerStatus.failure);
    }
  }

  Stream<ServicemanagerState> _mapServicemanagerImageChangedToState(
      ServicemanagerImageChanged event, ServicemanagerState state) async* {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: event.imageSource);
      if (pickedFile != null) {
        yield state.copyWith(
            image: new File(pickedFile.path), imageInvalid: false);
      } else {
        yield state.copyWith(image: state.image, imageInvalid: true);
      }
    } on Exception catch (_) {}
  }

  _mapServicemanagerNameChangedToState(
      ServicemanagerNameChanged event, ServicemanagerState state) {
    final value = ServiceFormz.dirty(event.name);
    return state.copyWith(
        servicename: value,
        formzStatus: Formz.validate([value, state.description]));
  }

  _mapServicemanagerDesciptionChangedToState(
      ServicemanagerDesciptionChanged event, ServicemanagerState state) {
    final value = DescriptionFormz.dirty(event.description);
    return state.copyWith(
        description: value,
        formzStatus: Formz.validate([value, state.servicename]));
  }

  Stream<ServicemanagerState> _mapServicemanagerDeleteSubmitedToState(
      ServiceManagerDeleteSubmited event, ServicemanagerState state) async* {
    yield state.copyWith(status: ServiceManagerStatus.loading);
    try {
      var response = await _dashboardRepository.deleteService(
        code: event.code,
      );
      if (response.statusCode == 200) {
        yield state.copyWith(
            status: ServiceManagerStatus.success,
            statusCode: 200,
            formzStatus: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(
            status: ServiceManagerStatus.failure,
            statusCode: 200,
            formzStatus: FormzStatus.submissionFailure);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: ServiceManagerStatus.failure);
    }
  }
}
