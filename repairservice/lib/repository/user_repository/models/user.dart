import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

class User extends Equatable {
  const User({this.isCustomer, this.role});
  final UserType isCustomer;
  final int role;
  @override
  List<Object> get props => [role, isCustomer];

  static const empty = User();
}
