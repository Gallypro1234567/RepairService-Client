part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Phone phone;
  final Password password;

  LoginState copyWith({
    FormzStatus status,
    Phone phone,
    Password password,
  }) {
    return LoginState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, phone, password];
}
