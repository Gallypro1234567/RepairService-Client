import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

part 'workerregistermanager_event.dart';
part 'workerregistermanager_state.dart';

class WorkerregistermanagerBloc
    extends Bloc<WorkerregistermanagerEvent, WorkerregistermanagerState> {
  WorkerregistermanagerBloc(
      {DashboardRepository dashboardRepository, PostRepository postRepository})
      : _dashboardRepository = dashboardRepository,
        _postRepository = postRepository,
        super(WorkerregistermanagerState());
  final DashboardRepository _dashboardRepository;
  final PostRepository _postRepository;
  @override
  Stream<WorkerregistermanagerState> mapEventToState(
    WorkerregistermanagerEvent event,
  ) async* {
    if (event is WorkerregistermanagerFetched)
      yield* _mapWorkerregistermanagerFetchedToState(event, state);
    else if (event is WorkerregistermanagerFetchedDetail)
      yield _mapWorkerregistermanagerFetchedDetailToState(event, state);
    else if (event is WorkerregistermanagerOpenPhoneCall)
      yield* _mapWorkerregistermanagerOpenPhoneCallToState(event, state);
    else if (event is WorkerregistermanagerCode)
      yield state.copyWith(workerOfServicesCode: event.value);
    else if (event is WorkerregistermanagerApprovalChanged)
      yield state.copyWith(formIsApproval: event.value, changed: true);
    else if (event is WorkerregistermanagerSubmit)
      yield* _mapWorkerregistermanagerSubmittedToState(event, state);
  }

  Stream<WorkerregistermanagerState>
      _mapWorkerregistermanagerOpenPhoneCallToState(
          WorkerregistermanagerOpenPhoneCall event,
          WorkerregistermanagerState state) async* {
    try {
      await launch("tel: ${event.phone}");
    } on Exception catch (_) {}
  }

  Stream<WorkerregistermanagerState> _mapWorkerregistermanagerFetchedToState(
      WorkerregistermanagerFetched event,
      WorkerregistermanagerState state) async* {
    yield state.copyWith(status: WorkerregistermanagerStatus.loading);
    try {
      var users = await _dashboardRepository.fetchWorkerRegister();
      yield state.copyWith(
          status: WorkerregistermanagerStatus.success,
          workerregister: users,
          workerOfServicesCode: "");
    } on Exception catch (_) {
      yield state.copyWith(status: WorkerregistermanagerStatus.failure);
    }
  }

  Stream<WorkerregistermanagerState> _mapWorkerregistermanagerSubmittedToState(
      WorkerregistermanagerSubmit event,
      WorkerregistermanagerState state) async* {
    yield state.copyWith(status: WorkerregistermanagerStatus.loading);
    try {
      var res = await _dashboardRepository.adminVetification(
          isApproval: state.formIsApproval,
          workerOfServicesCode: state.workerOfServicesCode);
      if (res.statusCode == 200) {
        if (state.formIsApproval != 0)
          await _postRepository.sendNotification(
              tilte: "Thông báo hệ thống",
              content: state.formIsApproval != 1
                  ? "đã không được duyệt"
                  : "đã phê duyệt thành công",
              receiveBy: event.workerPhone,
              postCode: state.workerOfServicesCode,
              status: state.formIsApproval + 1,
              type: 0);
        yield state.copyWith(
          status: WorkerregistermanagerStatus.submitted,
        );
      } else {
        yield state.copyWith(
          status: WorkerregistermanagerStatus.failure,
        );
      }
    } on Exception catch (_) {
      yield state.copyWith(status: WorkerregistermanagerStatus.failure);
    }
  }

  _mapWorkerregistermanagerFetchedDetailToState(
      WorkerregistermanagerFetchedDetail event,
      WorkerregistermanagerState state) {
    return state.copyWith(
        workerOfServicesCode: event.code,
        formIsApproval: event.isApproval,
        changed: false);
  }
}
