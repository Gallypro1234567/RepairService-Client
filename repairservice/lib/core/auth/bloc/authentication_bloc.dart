import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/user_repository/models/user.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    AuthenticationRepository authenticationRepository,
    UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  StreamSubscription<
          AuthenticationStatus> //late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield*  _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Stream<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async* {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        yield const AuthenticationState.unauthenticated();
        break;
      case AuthenticationStatus.authenticated:
        yield const AuthenticationState.unknown(); 
        final user = await _tryGetUser();
        yield user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
        break;
      default:
        yield const AuthenticationState.unknown();
        break;
    }
  }

  Future<UserDetail> _tryGetUser() async {
    try {
      final user = _userRepository.tryGetUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
