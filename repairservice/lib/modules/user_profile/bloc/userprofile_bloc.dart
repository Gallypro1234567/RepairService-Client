import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/core/user/login/models/login_phone.dart';
import 'package:repairservice/modules/user_profile/models/address.dart';
import 'package:repairservice/modules/user_profile/models/email.dart';
import 'package:repairservice/modules/user_profile/models/fullname.dart';
import 'package:repairservice/modules/user_profile/models/new_password.dart';
import 'package:repairservice/modules/user_profile/models/old_password.dart';
import 'package:repairservice/modules/user_profile/models/verify_password.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserProfileState());
  final UserRepository _userRepository;

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    if (event is UserProfileInitial) {
      // yield state.copyWith(
      //   fullname: Fullname.dirty(event.fullname),
      //   sex: event.sex,
      //   email: Email.dirty(event.email),
      //   address: Address.dirty(event.address),
      //   imageUrl: event.imageUrl,
      // );
      yield* _mapUserProfileFetchedToState(event, state);
    }
    // fullname
    else if (event is UserProfileFullnnameChanged) {
      yield _mapUserProfileFullnnameToState(event, state);
    }
    // sex
    else if (event is UserProfileSexChanged) {
      yield state.copyWith(sex: event.value);
    }
    // email
    else if (event is UserProfileEmailChanged) {
      yield state.copyWith(email: Email.dirty(event.value));
    }
    // address
    else if (event is UserProfileAddressChanged) {
      yield state.copyWith(address: Address.dirty(event.value));
    }
    // phone
    else if (event is UserProfilePhoneChanged) {
      yield state.copyWith(phone: Phone.dirty(event.value));
    }
    // old password
    else if (event is UserProfileOldPasswordChanged) {
      yield state.copyWith(oldpassword: OldPassword.dirty(event.value));
    }
    // new pasword
    else if (event is UserProfileNewPasswordChanged) {
      yield state.copyWith(newPassword: NewPassword.dirty(event.value));
    }
    // verify password
    else if (event is UserProfileVerifyPasswordChanged) {
      yield state.copyWith(
          verifyPassword: VerifyPassword.dirty(event.value),
          formzstatus: Formz.validate([
            state.oldpassword,
            state.newPassword,
            VerifyPassword.dirty(event.value)
          ]));
    }
    // button modify buttons
    else if (event is UserProfileUpdateSubmitted) {
      yield* _mapUserProfileUpdateToState(event, state);
    }
    // user profile change image
    else if (event is UserProfileImageLoading) {
      yield state.copyWith(fileStatus: FileStatus.loading);
    } else if (event is UserProfileImageChanged) {
      yield* _mapUserProfileImageChangedToState(event, state);
    }
  }

  Stream<UserProfileState> _mapUserProfileFetchedToState(
      UserProfileInitial event, UserProfileState state) async* {
    yield state.copyWith(status: UserProfileStatus.loading);
    try {
      var user = await _userRepository.fetchUser();
      yield state.copyWith(
          status: UserProfileStatus.success,
          data: user,
          fullname: Fullname.dirty(user.fullname),
          sex: user.sex,
          email: Email.dirty(user.email),
          address: Address.dirty(user.address),
          phone: Phone.dirty(user.phone),
          imageUrl: user.imageUrl);
    } on Exception catch (_) {
      yield state.copyWith(
        status: UserProfileStatus.failure,
      );
    }
  }

  _mapUserProfileFullnnameToState(
      UserProfileFullnnameChanged event, UserProfileState state) {
    final value = Fullname.dirty(event.value);
    return state.copyWith(
        fullname: value, formzstatus: Formz.validate([value]));
  }

  Stream<UserProfileState> _mapUserProfileUpdateToState(
      UserProfileUpdateSubmitted event, UserProfileState state) async* {
    if (state.newPassword.valid ||
        state.oldpassword.valid ||
        state.verifyPassword.valid) {
      if (state.oldpassword.value == state.newPassword.value) {
        yield state.copyWith(
            formzstatus: FormzStatus.submissionFailure, checkPass: 1);
      }
      if (state.newPassword.value != state.verifyPassword.value) {
        yield state.copyWith(
            formzstatus: FormzStatus.submissionFailure, checkPass: 2);
      }
    }
    yield state.copyWith(status: UserProfileStatus.loading);
    try {
      var a = await _userRepository.modifyOfUserProfile(
          phone: state.phone.value,
          fullname: state.fullname.value,
          sex: state.sex == Sex.male
              ? 1
              : state.sex == Sex.female
                  ? 2
                  : state.sex == Sex.orther
                      ? 3
                      : 0,
          email: state.email.value,
          address: state.address.value,
          oldpassword: state.oldpassword.value,
          newpassword: state.newPassword.value,
          file: state.file);

      if (a.statusCode == 200) {
        yield state.copyWith(
            status: UserProfileStatus.modified,
            formzstatus: FormzStatus.submissionSuccess,
            checkPass: 10);
      } else {
        yield state.copyWith(status: UserProfileStatus.failure);
      }
    } on Exception catch (_) {
      yield state.copyWith(
        status: UserProfileStatus.failure,
      );
    }
  }

  Stream<UserProfileState> _mapUserProfileImageChangedToState(
      UserProfileImageChanged event, UserProfileState state) async* {
    yield state.copyWith(fileStatus: FileStatus.loading);
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: event.imageSource);
      if (pickedFile != null) {
        yield state.copyWith(
            file: File(pickedFile.path), fileStatus: FileStatus.success);
      } else {
        yield state.copyWith(
          file: null,
        );
      }
    } on Exception catch (_) {
      yield state.copyWith(fileStatus: FileStatus.failure);
    }
  }
}
