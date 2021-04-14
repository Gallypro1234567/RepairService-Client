part of 'user_bloc.dart';

enum UserStatus { empty, loading, success, failure }

class UserState extends Equatable {
  const UserState(
      {this.user,
      this.statusCode = 200,
      this.message,
      this.status = UserStatus.empty});

  final int statusCode;
  final UserStatus status;
  final String message;
  final UserDetail user;

  @override
  List<Object> get props => [statusCode, status, message, user];

  UserState copyWith({
    int statusCode,
    UserStatus status,
    String message,
    UserDetail user,
  }) {
    return UserState(
      statusCode: statusCode ?? this.statusCode,
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}
