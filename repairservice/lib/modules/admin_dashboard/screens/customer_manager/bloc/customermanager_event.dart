part of 'customermanager_bloc.dart';

abstract class CustomermanagerEvent extends Equatable {
  const CustomermanagerEvent();

  @override
  List<Object> get props => [];
}

// Post
class CustomermanagerInitial extends CustomermanagerEvent {}
 
 