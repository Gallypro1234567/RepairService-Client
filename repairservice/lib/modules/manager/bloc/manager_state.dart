part of 'manager_bloc.dart';

enum PageStatus { loading, success, failure }

class ManagerState extends Equatable {
  const ManagerState({this.pageStatus, this.posts});
  final PageStatus pageStatus;
  final List<Post> posts;
  @override
  List<Object> get props => [pageStatus, posts];

  ManagerState copyWith({
    PageStatus pageStatus,
    List<Post> posts,
  }) {
    return ManagerState(
      pageStatus: pageStatus ?? this.pageStatus,
      posts: posts ?? this.posts,
    );
  }
}
