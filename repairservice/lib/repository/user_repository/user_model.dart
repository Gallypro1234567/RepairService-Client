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
  final int role;
  final int status;

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
      this.role,
      this.status,
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
        role,
        status,
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
      int role,
      int status,
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
        role: role ?? this.role,
        status: status ?? this.status,
        cmnd: cmnd ?? this.cmnd,
        imageUrl: imageUrl ?? this.imageUrl,
        imageUrlcmnd: imageUrlcmnd ?? this.imageUrlcmnd);
  }
}

class WorkerRegister extends Equatable {
  final String fullname;
  final String email;
  final String address;
  final String phone;
  final String code;
  final String createAt;
  final String cmnd;
  final String imageUrlcmnd;
  final String imageUrl;
  final int isApproval;
  final String serviceCode;
  final String serviceName;
  final String serviceImageurl;
  final double feedbackPoint;
  final int reviewAmount;
  WorkerRegister({
    this.email,
    this.address,
    this.phone,
    this.code,
    this.createAt,
    this.cmnd,
    this.imageUrlcmnd,
    this.imageUrl,
    this.isApproval,
    this.serviceCode,
    this.serviceName,
    this.serviceImageurl,
    this.feedbackPoint,
    this.reviewAmount,
    this.fullname,
  });

  @override
  List<Object> get props => [
        fullname,
        email,
        address,
        phone,
        code,
        createAt,
        cmnd,
        imageUrlcmnd,
        imageUrl,
        isApproval,
        serviceCode,
        serviceName,
        serviceImageurl,
        reviewAmount,
        fullname,
      ];
}

class FeedBack extends Equatable {
  final String username;
  final String userImageUrl;
  final String createAt;
  final String description;
  final double rate;

  FeedBack(
      {this.username,
      this.userImageUrl,
      this.createAt,
      this.description,
      this.rate});

  @override
  List<Object> get props =>
      [rate, username, userImageUrl, createAt, description];
}

class WorkerRate extends Equatable {
  final String fullname;
  final String phone;
  final String imageUrl;
  final String services;
  final double avgPoint;
  final int feedbackAmount;
  final int postAmount;
  final int finishAmount;
  final int cancelAmount;
  final double fivePercent;
  final double fourPercent;
  final double threePercent;
  final double twoPercent;
  final double onePercent;
  WorkerRate({
    this.fullname,
    this.phone,
    this.services,
    this.avgPoint,
    this.feedbackAmount,
    this.postAmount,
    this.finishAmount,
    this.cancelAmount,
    this.imageUrl,
    this.fivePercent,
    this.fourPercent,
    this.threePercent,
    this.twoPercent,
    this.onePercent,
  });

  @override
  List<Object> get props => [
        fullname,
        phone,
        services,
        avgPoint,
        feedbackAmount,
        postAmount,
        finishAmount,
        cancelAmount,
        imageUrl,
        fivePercent,
        fourPercent,
        threePercent,
        twoPercent,
        onePercent,
      ];
}

class UserRole extends Equatable {
  final UserType isCustomer;
  final int role;

  UserRole({this.isCustomer, this.role});

  @override
  List<Object> get props => [role, isCustomer];
}
