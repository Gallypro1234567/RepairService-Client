part of 'customerdetail_bloc.dart';

enum CustomerdetailStatus { loading, success, failure, submitted }

class CustomerdetailState extends Equatable {
  const CustomerdetailState(
      {this.status = CustomerdetailStatus.loading,
      this.detail = const <UserDetail>[],
      this.posts = const <Post>[]});

  final CustomerdetailStatus status;
  final List<UserDetail> detail;
  final List<Post> posts;
  @override
  List<Object> get props => [status, detail, posts];

  CustomerdetailState copyWith({
    CustomerdetailStatus status,
    List<UserDetail> detail,
    List<Post> posts,
  }) {
    return CustomerdetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
      posts: posts ?? this.posts,
    );
  }
}
