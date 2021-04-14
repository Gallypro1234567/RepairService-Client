part of 'userprofile_bloc.dart';

enum Sex { empty, male, female, orther }
enum UserProfileStatus { none, loading, success, failure }

class UserProfileState extends Equatable {
  const UserProfileState(
      {this.status = UserProfileStatus.none,
      this.formzstatus = FormzStatus.pure,
      this.data,
      this.fullname = const Fullname.pure(),
      this.sex = Sex.empty,
      this.email = const Email.pure(),
      this.address = const Address.pure(),
      this.phone = const Phone.pure(),
      this.oldpassword = const OldPassword.pure(),
      this.newPassword = const NewPassword.pure(),
      this.verifyPassword = const VerifyPassword.pure()});

  final UserProfileStatus status;
  final FormzStatus formzstatus;
  final UserDetail data;
  final Fullname fullname;
  final Sex sex;
  final Email email;
  final Address address;
  final Phone phone;
  final OldPassword oldpassword;
  final NewPassword newPassword;
  final VerifyPassword verifyPassword;
  @override
  List<Object> get props => [
        status,
        formzstatus,
        data,
        fullname,
        sex,
        email,
        address,
        phone,
        oldpassword,
        newPassword,
        verifyPassword
      ];

  UserProfileState copyWith({
    UserProfileStatus status,
    FormzStatus formzstatus,
    UserDetail data,
    Fullname fullname,
    Sex sex,
    Email email,
    Address address,
    Phone phone,
    OldPassword oldpassword,
    NewPassword newPassword,
    VerifyPassword verifyPassword,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      formzstatus: formzstatus ?? this.formzstatus,
      data: data ?? this.data,
      fullname: fullname ?? this.fullname,
      sex: sex ?? this.sex,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      oldpassword: oldpassword ?? this.oldpassword,
      newPassword: newPassword ?? this.newPassword,
      verifyPassword: verifyPassword ?? this.verifyPassword,
    );
  }
}
