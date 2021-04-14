part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class UserInitial extends UserEvent{}
class UserFetchDataSuccessed extends UserEvent{}
class UserFetchDataLoading extends UserEvent{}
class UserFetchDataFailure extends UserEvent{}