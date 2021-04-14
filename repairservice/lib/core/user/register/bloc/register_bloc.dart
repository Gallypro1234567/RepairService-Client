import 'dart:async'; 
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repairservice/core/user/register/models/register_fullname.dart';
import 'package:repairservice/core/user/register/models/register_password.dart';
import 'package:repairservice/core/user/register/models/register_password_verify.dart';
import 'package:repairservice/core/user/register/models/register_phone.dart';
import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/repository/user_repository/models/user_register_model.dart';
 

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({AuthenticationRepository repository})
      : _repository = repository,
        super(RegisterState());

  final AuthenticationRepository _repository;
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterInitial) {
      yield state.copyWith();
    } else if (event is RegisterWithAddPhone) {
      final phone = PhoneRegister.dirty(event.value);
      yield state.copyWith(phone: phone);
    } else if (event is RegisterFullnameChanged) {
      yield _mapRegisterFullnameToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapRegisterPasswordChangedToState(event, state);
    } else if (event is RegisterVerifyPasswordChanged) {
      yield _mapRegisterVerifyPasswordChangedToState(event, state);
    } else if (event is RegisterButtonSubmitted) {
      yield* _mapRegisterButtonSubmittedToState(event, state);
    } else if (event is RegisterRadioCustomerChanged) {
      yield state.copyWith(userType: event.value);
    }
  }

  _mapRegisterFullnameToState(
      RegisterFullnameChanged event, RegisterState state) {
    final fullname = FullnameRegister.dirty(event.value);
    return state.copyWith(
        fullname: fullname,
        status: Formz.validate(
            [fullname, state.phone, state.password, state.verifyPassword]));
  }

  _mapRegisterPasswordChangedToState(
      RegisterPasswordChanged event, RegisterState state) {
    final pass = PasswordRegister.dirty(event.value);
    return state.copyWith(
        password: pass,
        status: Formz.validate(
            [state.fullname, state.phone, pass, state.verifyPassword]));
  }

  _mapRegisterVerifyPasswordChangedToState(
      RegisterVerifyPasswordChanged event, RegisterState state) {
    final verifypass = PasswordVerifyRegister.dirty(event.value);
    return state.copyWith(
        verifyPassword: verifypass,
        status: Formz.validate(
            [verifypass, state.fullname, state.password, state.phone]));
  }

  Stream<RegisterState> _mapRegisterButtonSubmittedToState(
      RegisterButtonSubmitted event, RegisterState state) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      var response = await _repository.register(new RegisterModel(
        fullname: state.fullname.value,
        password: state.password.value,
        phone: state.phone.value,
        isCustomer: state.userType == UserType.customer ? true : false,
      ));
      if (response.statusCode == 200) {
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
