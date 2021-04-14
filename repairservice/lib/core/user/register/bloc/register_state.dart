part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.status = FormzStatus.pure,
      this.fullname = const FullnameRegister.pure(),
      this.phone = const PhoneRegister.pure(),
      this.password = const PasswordRegister.pure(),
      this.verifyPassword = const PasswordVerifyRegister.pure(),
      this.isCustomer = true});
  final FormzStatus status;
  final FullnameRegister fullname;
  final PhoneRegister phone;
  final PasswordRegister password;
  final PasswordVerifyRegister verifyPassword;
  final bool isCustomer;
  @override
  List<Object> get props =>
      [status, fullname, phone, password, verifyPassword, isCustomer];

  RegisterState copyWith(
      {FormzStatus status,
      FullnameRegister fullname,
      PhoneRegister phone,
      PasswordRegister password,
      PasswordVerifyRegister verifyPassword,
      final bool isCustomer}) {
    return RegisterState(
        status: status ?? this.status,
        fullname: fullname ?? this.fullname,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        verifyPassword: verifyPassword ?? this.verifyPassword,
        isCustomer: isCustomer ?? this.isCustomer);
  }
}
