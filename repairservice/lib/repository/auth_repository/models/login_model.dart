import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

class Login extends Equatable {
  final int statusCode;
  final int role;
  final UserType isCustomer;

  Login({
    this.statusCode,
    this.role,
    this.isCustomer,
  });

  @override
  List<Object> get props => [statusCode, role, isCustomer];
}
