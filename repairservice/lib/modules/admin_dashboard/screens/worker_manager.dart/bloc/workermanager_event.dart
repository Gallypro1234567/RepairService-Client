part of 'workermanager_bloc.dart';

abstract class WorkermanagerEvent extends Equatable {
  const WorkermanagerEvent();

  @override
  List<Object> get props => [];
}
 
class WorkermanagerInitial extends WorkermanagerEvent {}