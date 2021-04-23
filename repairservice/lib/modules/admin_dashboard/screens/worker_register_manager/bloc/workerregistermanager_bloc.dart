import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';

part 'workerregistermanager_event.dart';
part 'workerregistermanager_state.dart';

class WorkerregistermanagerBloc
    extends Bloc<WorkerregistermanagerEvent, WorkerregistermanagerState> {
  WorkerregistermanagerBloc({DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(WorkerregistermanagerState());
  final DashboardRepository _dashboardRepository;
  @override
  Stream<WorkerregistermanagerState> mapEventToState(
    WorkerregistermanagerEvent event,
  ) async* {
    if (event is WorkerregistermanagerFetched) {
      yield* _mapWorkerregistermanagerFetchedToState(event, state);
    }
  }

  Stream<WorkerregistermanagerState> _mapWorkerregistermanagerFetchedToState(
      WorkerregistermanagerFetched event,
      WorkerregistermanagerState state) async* {
    yield state.copyWith(status: WorkerregistermanagerStatus.loading);
    try {
      var users = await _dashboardRepository.fetchWorkerRegister();
      yield state.copyWith(
          status: WorkerregistermanagerStatus.success, workerregister: users);
    } on Exception catch (_) {
      yield state.copyWith(status: WorkerregistermanagerStatus.failure);
    }
  }
}
