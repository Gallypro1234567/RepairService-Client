part of 'postdetailperfect_bloc.dart';

abstract class PostdetailperfectEvent extends Equatable {
  const PostdetailperfectEvent();

  @override
  List<Object> get props => [];
}

class PostdetailperfectInitial extends PostdetailperfectEvent {}

class PostdetailperfectFetched extends PostdetailperfectEvent {
  final String postCode;
  final bool isCustomer;
  PostdetailperfectFetched({this.postCode, this.isCustomer});
}

class PostdetailperfectWorkerSubmited extends PostdetailperfectEvent {}
class PostdetailWorkerCancelSubmited extends PostdetailperfectEvent {}
class PostdetailPerfectCustomerSubmited extends PostdetailperfectEvent {}