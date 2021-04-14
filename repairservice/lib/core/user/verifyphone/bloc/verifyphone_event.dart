part of 'verifyphone_bloc.dart';

abstract class VerifyphoneEvent extends Equatable {
  const VerifyphoneEvent();

  @override
  List<Object> get props => [];
}

class VerifyPhoneInitial extends VerifyphoneEvent {}

class VerifyPhoneInputChanged extends VerifyphoneEvent {
  final String phone;

  const VerifyPhoneInputChanged(this.phone);
}

class VerifyPhoneSubmitted extends VerifyphoneEvent { 
  const VerifyPhoneSubmitted();
}
