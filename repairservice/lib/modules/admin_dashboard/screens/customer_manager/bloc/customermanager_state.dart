part of 'customermanager_bloc.dart';

enum CustomermanagerStatus { none, loading, success, failure }

class CustomermanagerState extends Equatable {
  const CustomermanagerState({
    this.status = CustomermanagerStatus.none,
    this.users = const <UserDetail>[],
  });
  final CustomermanagerStatus status;
  final List<UserDetail> users;

  @override
  List<Object> get props => [status, users];

  CustomermanagerState copyWith({
    CustomermanagerStatus status,
    List<UserDetail> users,
  }) {
    return CustomermanagerState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
