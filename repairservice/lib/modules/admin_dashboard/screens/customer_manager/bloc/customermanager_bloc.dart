import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';

part 'customermanager_event.dart';
part 'customermanager_state.dart';

class CustomermanagerBloc
    extends Bloc<CustomermanagerEvent, CustomermanagerState> {
  CustomermanagerBloc({DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(CustomermanagerState());

  final DashboardRepository _dashboardRepository;
  @override
  Stream<CustomermanagerState> mapEventToState(
    CustomermanagerEvent event,
  ) async* {
    if (event is CustomermanagerInitial) {
      yield* _mapCustomermanagerInitialToState(event, state);
    }
  }

  Stream<CustomermanagerState> _mapCustomermanagerInitialToState(
      CustomermanagerInitial event, CustomermanagerState state) async* {
    yield state.copyWith(status: CustomermanagerStatus.loading);
    try {
      var users = await _dashboardRepository.fetchCustomers();
      yield state.copyWith(status: CustomermanagerStatus.success, users: users);
    } on Exception catch (_) {
      yield state.copyWith(status: CustomermanagerStatus.failure);
    }
  }
}
