part of 'postmanager_bloc.dart';

enum PostManagerStatus { loading, success, failure }

class PostmanagerState extends Equatable {
  const PostmanagerState({this.status, this.posts = const <Post>[]});
  final PostManagerStatus status;
  final List<Post> posts;

  @override
  List<Object> get props => [status, posts];

  PostmanagerState copyWith({
    PostManagerStatus status,
    List<Post> posts,
  }) {
    return PostmanagerState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}

 
