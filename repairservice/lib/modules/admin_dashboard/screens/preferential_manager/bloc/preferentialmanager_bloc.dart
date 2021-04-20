import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/home_repository/home_repository.dart';

part 'preferentialmanager_event.dart';
part 'preferentialmanager_state.dart';

class PreferentialmanagerBloc
    extends Bloc<PreferentialmanagerEvent, PreferentialmanagerState> {
  PreferentialmanagerBloc({HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(PreferentialmanagerState());
  final HomeRepository _homeRepository;
  @override
  Stream<PreferentialmanagerState> mapEventToState(
    PreferentialmanagerEvent event,
  ) async* {
    if (event is PreferentialmanagerInitial) {
      yield state.copyWith();
    } else if (event is PreferentialmanagerTitleChanged) {
      yield state.copyWith(title: event.value);
    } else if (event is PreferentialmanagerDescriptionChanged) {
      yield state.copyWith(description: event.value);
    } else if (event is PreferentialmanagerFromDateChanged) {
      yield state.copyWith(fromdate: event.value);
    } else if (event is PreferentialmanagerToDateChanged) {
      yield state.copyWith(todate: event.value);
    } else if (event is PreferentialmanagerPercentChanged) {
      yield state.copyWith(percent: event.value);
    } else if (event is PreferentialmanagerImageChanged) {
      yield state.copyWith(image: event.file);
    } else if (event is PreferentialmanagerSubmitted) {
      yield* _mapPreferentialmanagerSubmitted(event, state);
    }
  }

  Stream<PreferentialmanagerState> _mapPreferentialmanagerSubmitted(
      PreferentialmanagerSubmitted event,
      PreferentialmanagerState state) async* {
    yield state.copyWith(status: PreferentialManagerStatus.loading);
    try {
      var response = await _homeRepository.addPreferential(
          title: state.title,
          description: state.title,
          fromdate: state.fromdate,
          todate: state.todate,
          percent: state.percent,
          file: state.image,
          serviceCodes: state.servicecodes);
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        yield state.copyWith(status: PreferentialManagerStatus.success);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: PreferentialManagerStatus.failure);
    }
  }
}
