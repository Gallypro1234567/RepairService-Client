part of 'manager_bloc.dart';

abstract class ManagerEvent extends Equatable {
  const ManagerEvent();

  @override
  List<Object> get props => [];
}
 class ManagerFetched extends ManagerEvent {}