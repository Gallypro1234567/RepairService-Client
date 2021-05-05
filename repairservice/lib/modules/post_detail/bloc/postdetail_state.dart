part of 'postdetail_bloc.dart';

enum PostDetailStatus { loading, none, success, failure, submitted }

class PostdetailState extends Equatable {
  const PostdetailState(
      {this.status = PostDetailStatus.none, this.post, this.statusApply = 0});
  final PostDetailStatus status;
  final Post post;
  final int statusApply;
  @override
  List<Object> get props => [status, post, statusApply];

  PostdetailState copyWith(
      {PostDetailStatus status, Post post, int statusApply}) {
    return PostdetailState(
        status: status ?? this.status,
        post: post ?? this.post,
        statusApply: statusApply ?? this.statusApply);
  }
}
