import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final String phone;
  final String fullname;
  final String password;
  final bool isCustomer;

  RegisterModel({this.phone, this.fullname, this.password, this.isCustomer});
  @override
  List<Object> get props => [fullname, phone, password, isCustomer];
}
