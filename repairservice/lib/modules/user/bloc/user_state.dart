part of 'user_bloc.dart';

enum UserStatus { empty, loading, success, failure }

class UserState extends Equatable {
  const UserState(
      {this.user,
      this.statusCode = 200,
      this.message,
      this.workeRegister = const <WorkerRegister>[],
      this.status = UserStatus.empty});

  final int statusCode;
  final UserStatus status;
  final String message;
  final UserDetail user;
  final List<WorkerRegister> workeRegister;
  @override
  List<Object> get props => [statusCode, status, message, user, workeRegister];

  UserState copyWith(
      {int statusCode,
      UserStatus status,
      String message,
      UserDetail user,
      List<WorkerRegister> workeRegister}) {
    return UserState(
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
        message: message ?? this.message,
        user: user ?? this.user,
        workeRegister: workeRegister ?? this.workeRegister);
  }
}
