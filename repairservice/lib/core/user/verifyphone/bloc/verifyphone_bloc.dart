import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repairservice/core/user/register/models/register_phone.dart';

part 'verifyphone_event.dart';
part 'verifyphone_state.dart';

class VerifyPhoneBloc extends Bloc<VerifyphoneEvent, VerifyPhoneState> {
  VerifyPhoneBloc() : super(const VerifyPhoneState());

  @override
  Stream<VerifyPhoneState> mapEventToState(
    VerifyphoneEvent event,
  ) async* {
    if (event is VerifyPhoneInitial) {
      yield state.copyWith();
    } else if (event is VerifyPhoneInputChanged) {
      yield _mapVerifyPhoneInputChangedToState(event, state);
    } else if (event is VerifyPhoneSubmitted) {
      yield _mapVerifyPhoneSubmittedToState(event, state);
    }
  }

  _mapVerifyPhoneInputChangedToState(
      VerifyPhoneInputChanged event, VerifyPhoneState state) {
    final phone = PhoneRegister.dirty(event.phone);
    return state.copyWith(phone: phone, status: Formz.validate([phone]));
  }

  _mapVerifyPhoneSubmittedToState(
      VerifyPhoneSubmitted event, VerifyPhoneState state) {
    
  }
}
