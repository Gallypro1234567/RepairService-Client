part of 'postdetail_bloc.dart';

enum PostDetailStatus { loading, none, success, failure, submitted }

class PostdetailState extends Equatable {
  const PostdetailState({this.status = PostDetailStatus.none, this.post});
  final PostDetailStatus status;
  final Post post;
  
  @override
  List<Object> get props => [status, post];

  PostdetailState copyWith({
    PostDetailStatus status,
    Post post,
  }) {
    return PostdetailState(
      status: status ?? this.status,
      post: post ?? this.post,
    );
  }
}
