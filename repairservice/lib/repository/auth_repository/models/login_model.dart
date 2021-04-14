import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final int statusCode;

  Login({
    this.statusCode,
  });

  @override
  List<Object> get props => [statusCode];
}
