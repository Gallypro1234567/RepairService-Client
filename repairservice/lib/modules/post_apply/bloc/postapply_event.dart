part of 'postapply_bloc.dart';

abstract class PostapplyEvent extends Equatable {
  const PostapplyEvent();

  @override
  List<Object> get props => [];
}

class PostApplyInitial extends PostapplyEvent {}

class PostapplyFetched extends PostapplyEvent {
  final String postCode;

  PostapplyFetched(this.postCode);
} 
 