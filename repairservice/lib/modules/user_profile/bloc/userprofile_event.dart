part of 'userprofile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

// load
class UserProfileInitial extends UserProfileEvent {
  // final String fullname;
  // final Sex sex;
  // final String email;
  // final String address;
  // final String phone;
  // final String imageUrl;

  // UserProfileInitial(this.fullname, this.sex, this.email, this.address, this.phone, this.imageUrl);
}

class UserProfileLoading extends UserProfileEvent {}

class UserProfileFailure extends UserProfileEvent {}

//form
class UserProfileFullnnameChanged extends UserProfileEvent {
  final String value;
  UserProfileFullnnameChanged(this.value);
}

class UserProfileSexChanged extends UserProfileEvent {
  final Sex value;
  UserProfileSexChanged(this.value);
}

class UserProfileEmailChanged extends UserProfileEvent {
  final String value;

  UserProfileEmailChanged(this.value);
}

class UserProfileAddressChanged extends UserProfileEvent {
  final String value;

  UserProfileAddressChanged(this.value);
}

class UserProfilePhoneChanged extends UserProfileEvent {
  final String value;

  UserProfilePhoneChanged(this.value);
}

class UserProfileOldPasswordChanged extends UserProfileEvent {
  final String value;

  UserProfileOldPasswordChanged(this.value);
}

class UserProfileNewPasswordChanged extends UserProfileEvent {
  final String value;

  UserProfileNewPasswordChanged(this.value);
}

class UserProfileVerifyPasswordChanged extends UserProfileEvent {
  final String value;

  UserProfileVerifyPasswordChanged(this.value);
}

// Image
class UserProfileImageLoading extends UserProfileEvent {}

class UserProfileImageChanged extends UserProfileEvent {
  final ImageSource imageSource;
  UserProfileImageChanged(this.imageSource);
}

class UserProfileUpdateSubmitted extends UserProfileEvent {}
