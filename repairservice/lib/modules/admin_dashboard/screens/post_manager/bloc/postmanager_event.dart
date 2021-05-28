part of 'postmanager_bloc.dart';

abstract class PostmanagerEvent extends Equatable {
  const PostmanagerEvent();

  @override
  List<Object> get props => [];
}

class PostmanagerInitial extends PostmanagerEvent {}

class PostmanagerFetched extends PostmanagerEvent {}

class PostmanagerApproval extends PostmanagerEvent {}