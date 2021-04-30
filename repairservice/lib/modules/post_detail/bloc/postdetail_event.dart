part of 'postdetail_bloc.dart';

class PostdetailEvent extends Equatable {
  const PostdetailEvent();

  @override
  List<Object> get props => [];
}

class PostdetailInitial extends PostdetailEvent {}

class PostdetailFetched extends PostdetailEvent {
  final String postCode;

  PostdetailFetched(this.postCode);
}
class PostdetailWorkerApplySubmitted extends PostdetailEvent {
  final String postCode;

  PostdetailWorkerApplySubmitted(this.postCode);
}