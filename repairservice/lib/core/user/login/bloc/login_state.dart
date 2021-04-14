part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.statusCode = 200,
    this.mesagge = "",
    this.status = FormzStatus.pure,
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final int statusCode;
  final String mesagge;
  final Phone phone;
  final Password password;

  @override
  List<Object> get props => [status, phone, password];

   

  LoginState copyWith({
    FormzStatus status,
    int statusCode,
    String mesagge,
    Phone phone,
    Password password,
  }) {
    return LoginState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      mesagge: mesagge ?? this.mesagge,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
