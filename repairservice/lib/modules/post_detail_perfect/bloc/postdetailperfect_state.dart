part of 'postdetailperfect_bloc.dart';

enum PostPerfectStatus {
  loading,
  loadsuccess,
  perfectSubmitted,
  cancelSubmitted,
  customersubmitted,
  failure
}

class PostdetailperfectState extends Equatable {
  const PostdetailperfectState(
      {this.status, this.isCustomer, this.post, this.postCode});
  final PostPerfectStatus status;
  final bool isCustomer;
  final PostPerfect post;
  final String postCode;
  @override
  List<Object> get props => [status, isCustomer, post, postCode];
  PostdetailperfectState copyWith(
      {PostPerfectStatus status,
      bool isCustomer,
      PostPerfect post,
      String postCode}) {
    return PostdetailperfectState(
        status: status ?? this.status,
        isCustomer: isCustomer ?? this.isCustomer,
        postCode: postCode ?? this.postCode,
        post: post ?? this.post);
  }
}
