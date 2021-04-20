import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/modules/post_find_worker/models/description.dart';
import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/service/server_hosting.dart' as Host;
import 'package:http/http.dart' as http;
part 'servicemanager_event.dart';
part 'servicemanager_state.dart';

class ServicemanagerBloc
    extends Bloc<ServicemanagerEvent, ServicemanagerState> {
  ServicemanagerBloc({HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(ServicemanagerState());
  final HomeRepository _homeRepository;
  @override
  Stream<ServicemanagerState> mapEventToState(
    ServicemanagerEvent event,
  ) async* {
    if (event is ServicemanagerInitial) {
      yield state.copyWith();
    } else if (event is ServicemanagerNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is ServicemanagerDesciptionChanged) {
      yield state.copyWith(name: event.description);
    } else if (event is ServicemanagerImageChanged) {
      yield state.copyWith(image: event.file);
    } else if (event is ServicemanagerEventSubmited) {
      yield* _mapServicemanagerEventSubmitedToState(event, state);
    }
  }

  Stream<ServicemanagerState> _mapServicemanagerEventSubmitedToState(
      ServicemanagerEventSubmited event, ServicemanagerState state) async* {
    yield state.copyWith(status: ServiceManagerStatus.loading);
    try {
      var response = await _homeRepository.addService(
          name: state.name, description: state.description, file: state.image);
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        yield state.copyWith(
            status: ServiceManagerStatus.success, statusCode: 200);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: ServiceManagerStatus.failure);
    }
  }
}
