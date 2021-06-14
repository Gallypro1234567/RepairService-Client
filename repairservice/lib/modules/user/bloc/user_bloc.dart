import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/user_repository/models/user.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserState());
  final UserRepository _userRepository;
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserInitial) {
      yield state.copyWith(
          workeRegister: <WorkerRegister>[], status: UserStatus.empty);
    } else if (event is UserFetch) {
      yield* _mapUserFetchToState(event, state);
    } else if (event is UserFetchDataLoading) {
      yield state.copyWith(status: UserStatus.loading);
    } else if (event is UserFetchDataFailure) {
      yield state.copyWith(status: UserStatus.failure);
    } else if (event is UserFetchDataSuccessed) {
      yield state.copyWith(status: UserStatus.success);
    }
  }

  Stream<UserState> _mapUserFetchDataSuccessedToState(
      UserFetchDataSuccessed event, UserState state) async* {
    yield state.copyWith(status: UserStatus.loading);
    try {
      var user = await _userRepository.fetchUser();

      yield state.copyWith(status: UserStatus.success, user: user);
    } on Exception catch (e) {
      yield state.copyWith(status: UserStatus.failure, message: e.toString());
    }
  }

  Stream<UserState> _mapUserFetchToState(
      UserFetch event, UserState state) async* {
    yield state.copyWith(status: UserStatus.loading);
    try {
      var user = await _userRepository.fetchUser();
      if (user.isCustomer == UserType.worker) {
        var serviceList = await _userRepository.fetchWorkerRegisterByUser();
        yield state.copyWith(
            status: UserStatus.success, user: user, workeRegister: serviceList);
      } else {
        yield state.copyWith(status: UserStatus.success, user: user);
      }
    } on Exception catch (e) {
      yield state.copyWith(status: UserStatus.failure, message: e.toString());
    }
  }
}
