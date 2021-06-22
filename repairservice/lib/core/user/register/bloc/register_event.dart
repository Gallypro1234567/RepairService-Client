part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterEvent {}

class RegisterWithAddPhone extends RegisterEvent {
  final String value;

  const RegisterWithAddPhone(this.value);
}

class RegisterFullnameChanged extends RegisterEvent {
  final String value;

  const RegisterFullnameChanged(this.value);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String value;

  const RegisterPasswordChanged(this.value);
}
class RegisterPasswordChecked extends RegisterEvent {
  final String value;

  const RegisterPasswordChecked(this.value);
}
class RegisterRadioCustomerChanged extends RegisterEvent {
  final UserType value;

  const RegisterRadioCustomerChanged(this.value);
}

class RegisterVerifyPasswordChanged extends RegisterEvent {
  final String value; 
  const RegisterVerifyPasswordChanged(this.value);
}

class RegisterButtonSubmitted extends RegisterEvent {}
