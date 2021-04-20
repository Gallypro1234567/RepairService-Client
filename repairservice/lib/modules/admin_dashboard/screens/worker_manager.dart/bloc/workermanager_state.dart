part of 'workermanager_bloc.dart';
 
enum WorkermanagerStatus { none, loading, success, failure }

class WorkermanagerState extends Equatable {
  const WorkermanagerState({
    this.status = WorkermanagerStatus.none,
    this.users = const <UserDetail>[],
  });
  final WorkermanagerStatus status;
  final List<UserDetail> users;

  @override
  List<Object> get props => [status, users];

  WorkermanagerState copyWith({
    WorkermanagerStatus status,
    List<UserDetail> users,
  }) {
    return WorkermanagerState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
