part of 'postapply_bloc.dart';

enum ApplyStatus { loading, success, failure }
enum AcceptStatus { none, accept, cancel }

class PostapplyState extends Equatable {
  const PostapplyState(
      {this.postApply,
      this.status = ApplyStatus.loading,
      this.acceptStatus = AcceptStatus.none});
  final List<WorkerApply> postApply;
  final ApplyStatus status;
  final AcceptStatus acceptStatus;
  @override
  List<Object> get props => [status, postApply, acceptStatus];

  PostapplyState copyWith(
      {List<WorkerApply> postApply,
      ApplyStatus status,
      AcceptStatus acceptStatus}) {
    return PostapplyState(
        postApply: postApply ?? this.postApply,
        status: status ?? this.status,
        acceptStatus: acceptStatus ?? this.acceptStatus);
  }
}
