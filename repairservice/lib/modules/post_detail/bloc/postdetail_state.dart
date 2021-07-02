part of 'postdetail_bloc.dart';

enum PostDetailStatus { loading, none, success, failure, submitted, isSubmitProccessing }

class PostdetailState extends Equatable {
  const PostdetailState(
      {this.status = PostDetailStatus.none,
      this.post,
      this.statusApply = 0,
      this.postCode});
  final PostDetailStatus status;
  final Post post;
  final int statusApply;
  final String postCode;
  @override
  List<Object> get props => [status, post, statusApply, postCode];

  PostdetailState copyWith(
      {PostDetailStatus status, Post post, int statusApply, String postCode}) {
    return PostdetailState(
        status: status ?? this.status,
        post: post ?? this.post,
        postCode: postCode ?? this.postCode,
        statusApply: statusApply ?? this.statusApply);
  }
}
