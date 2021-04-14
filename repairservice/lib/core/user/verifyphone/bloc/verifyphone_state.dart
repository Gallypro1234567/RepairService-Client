part of 'verifyphone_bloc.dart';

enum VerifyPhoneStatus { emty, success }

class VerifyPhoneState extends Equatable {
  const VerifyPhoneState({
    this.status = FormzStatus.pure,
    this.statusCode = 0,
    this.phone = const PhoneRegister.pure(),
    this.isVerifySuccessed = false,
  });

  final FormzStatus status;
  final int statusCode;
  final PhoneRegister phone;
  final bool isVerifySuccessed;

  @override
  List<Object> get props => [status, phone, statusCode, isVerifySuccessed];

   

  VerifyPhoneState copyWith({
    FormzStatus status,
    int statusCode,
    PhoneRegister phone,
    bool isVerifySuccessed,
  }) {
    return VerifyPhoneState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      phone: phone ?? this.phone,
      isVerifySuccessed: isVerifySuccessed ?? this.isVerifySuccessed,
    );
  }
}
