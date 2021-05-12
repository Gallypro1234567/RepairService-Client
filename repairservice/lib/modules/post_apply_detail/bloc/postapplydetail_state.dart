part of 'postapplydetail_bloc.dart';

enum ApplyDetailStatus { loading, success, acceptSubmitted,cancelSubmitted, failure }
enum AcceptStatus { none, accept, cancel }

class PostapplydetailState extends Equatable {
  const PostapplydetailState(
      {this.postApply,
      this.status = ApplyDetailStatus.loading,
      this.acceptStatus,
      this.postCode,
      this.wofscode});
  final WorkerApply postApply;
  final ApplyDetailStatus status;
  final AcceptStatus acceptStatus;
  final String postCode;
  final String wofscode;
  @override
  List<Object> get props =>
      [status, postApply, acceptStatus, postCode, wofscode];

  PostapplydetailState copyWith(
      {WorkerApply postApply,
      ApplyDetailStatus status,
      AcceptStatus acceptStatus,
      String postCode,
      String wofscode}) {
    return PostapplydetailState(
        postApply: postApply ?? this.postApply,
        status: status ?? this.status,
        acceptStatus: acceptStatus ?? this.acceptStatus,
        postCode: postCode ?? this.postCode,
        wofscode: wofscode ?? this.wofscode);
  }
}
