import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';

part 'workermanager_event.dart';
part 'workermanager_state.dart';

class WorkermanagerBloc extends Bloc<WorkermanagerEvent, WorkermanagerState> {
  WorkermanagerBloc({DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(WorkermanagerState());
  final DashboardRepository _dashboardRepository;
  @override
  Stream<WorkermanagerState> mapEventToState(
    WorkermanagerEvent event,
  ) async* {
    if (event is WorkermanagerInitial) {
      yield* _mapWorkermanagerInitialToState(event, state);
    }
  }

  Stream<WorkermanagerState> _mapWorkermanagerInitialToState(
      WorkermanagerInitial event, WorkermanagerState state) async* {
    yield state.copyWith(status: WorkermanagerStatus.loading);
    try {
      var users = await _dashboardRepository.fetchWorker();
      yield state.copyWith(status: WorkermanagerStatus.success, users: users);
    } on Exception catch (_) {
      yield state.copyWith(status: WorkermanagerStatus.failure);
    }
  }
}
