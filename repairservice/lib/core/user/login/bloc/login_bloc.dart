import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repairservice/core/user/login/models/login_pasword.dart';
import 'package:repairservice/core/user/login/models/login_phone.dart';
import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPhoneChanged) {
      yield __mapPhoneChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield __mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is LogOuttSubmitted) {
      yield* _mapLogOutSubmittedToState(event, state);
    } else if (event is NavigateRegistertSubmit) {
      yield* _mapNavigatorPushtoRegisterSubmitToState(event, state);
    }
  }

  __mapPhoneChangedToState(LoginPhoneChanged event, LoginState state) {
    final phone = Phone.dirty(event.username);
    return state.copyWith(
        phone: phone, status: Formz.validate([state.password, phone]));
  }

  __mapPasswordChangedToState(LoginPasswordChanged event, LoginState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
        password: password, status: Formz.validate([state.phone, password]));
  }

  Stream<LoginState> _mapLoginSubmittedToState(
      LoginSubmitted event, LoginState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress, statusCode: 200);
      try {
        var response = await _authenticationRepository.logIn(
          phone: state.phone.value,
          password: state.password.value,
        );

        if (response.statusCode == 200) {
          yield state.copyWith(
              status: FormzStatus.submissionSuccess,
              statusCode: response.statusCode); 
         
        } else if (response.statusCode == 400) {
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              statusCode: response.statusCode);
        } else if (response.statusCode == 404) {
          _controller.add(AuthenticationStatus.unauthenticated);
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              statusCode: response.statusCode);
        }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  _mapLogOutSubmittedToState(LogOuttSubmitted event, LoginState state) {
    _authenticationRepository.logOut();
  }

  _mapNavigatorPushtoRegisterSubmitToState(
      NavigateRegistertSubmit event, LoginState state) {}
}
