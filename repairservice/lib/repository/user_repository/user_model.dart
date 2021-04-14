import 'package:equatable/equatable.dart';

import 'models/user_enum.dart';

class UserDetail extends Equatable {
  final String fullname;
  final Sex sex;
  final String email;
  final String address;
  final String phone;

  final String password;
  final String newpassword;
  final String verifyPassword;
  final UserType isCustomer;

  final String cmnd;
  final String imageUrlcmnd;
  final String imageUrl;
  UserDetail(
      {this.fullname,
      this.sex,
      this.email,
      this.address,
      this.phone,
      this.password,
      this.newpassword,
      this.verifyPassword,
      this.isCustomer,
      this.cmnd,
      this.imageUrlcmnd,
      this.imageUrl});
  @override
  List<Object> get props => [
        fullname,
        sex,
        email,
        address,
        phone,
        password,
        newpassword,
        verifyPassword,
        isCustomer,
        cmnd,
        imageUrlcmnd,
        imageUrl
      ];

  UserDetail copyWith(
      {String fullname,
      Sex sex,
      String email,
      String address,
      String phone,
      String password,
      String newpassword,
      String verifyPassword,
      UserType isCustomer,
      String cmnd,
      String imageUrl,
      String imageUrlcmnd}) {
    return UserDetail(
        fullname: fullname ?? this.fullname,
        sex: sex ?? this.sex,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        newpassword: newpassword ?? this.newpassword,
        verifyPassword: verifyPassword ?? this.verifyPassword,
        isCustomer: isCustomer ?? this.isCustomer,
        cmnd: cmnd ?? this.cmnd,
        imageUrl: imageUrl ?? this.imageUrl,
        imageUrlcmnd: imageUrlcmnd ?? this.imageUrlcmnd);
  }
}
