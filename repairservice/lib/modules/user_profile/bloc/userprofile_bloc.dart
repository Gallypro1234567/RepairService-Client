import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repairservice/core/user/login/models/login_phone.dart';
import 'package:repairservice/modules/user_profile/models/address.dart';
import 'package:repairservice/modules/user_profile/models/email.dart';
import 'package:repairservice/modules/user_profile/models/fullname.dart';
import 'package:repairservice/modules/user_profile/models/new_password.dart';
import 'package:repairservice/modules/user_profile/models/old_password.dart';
import 'package:repairservice/modules/user_profile/models/verify_password.dart';
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
    if (event is UserProfileFetched) {
      yield* _mapUserProfileFetchedToState(event, state);
    } else if (event is UserProfileFullnnameChanged) {
      yield _mapUserProfileFullnnameToState(event, state);
    } else if (event is UserProfileSexChanged) {
      yield state.copyWith(sex: event.value);
    } else if (event is UserProfileEmailChanged) {
      yield state.copyWith(email: Email.dirty(event.value));
    } else if (event is UserProfileAddressChanged) {
      yield state.copyWith(address: Address.dirty(event.value));
    } else if (event is UserProfilePhoneChanged) {
      yield state.copyWith(phone: Phone.dirty(event.value));
    } else if (event is UserProfileOldPasswordChanged) {
      yield state.copyWith(oldpassword: OldPassword.dirty(event.value));
    } else if (event is UserProfileNewPasswordChanged) {
      yield state.copyWith(newPassword: NewPassword.dirty(event.value));
    } else if (event is UserProfileVerifyPasswordChanged) {
      yield state.copyWith(verifyPassword: VerifyPassword.dirty(event.value));
    }
  }

  Stream<UserProfileState> _mapUserProfileFetchedToState(
      UserProfileFetched event, UserProfileState state) async* {
    yield state.copyWith(status: UserProfileStatus.loading);
    try {
      var user = await _userRepository.fetchUser();

      yield state.copyWith(status: UserProfileStatus.success, data: user);
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
}
