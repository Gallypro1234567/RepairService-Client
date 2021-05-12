part of 'postapplydetail_bloc.dart';

abstract class PostapplydetailEvent extends Equatable {
  const PostapplydetailEvent();

  @override
  List<Object> get props => [];
}

class PostApplyDetailInitial extends PostapplydetailEvent {}

class PostApplyDetailFetched extends PostapplydetailEvent {
  final String phone;
  final String wofscode;
  final String postCode;
  PostApplyDetailFetched({this.phone, this.wofscode, this.postCode});
}

class PostApplyOpenPhoneCall extends PostapplydetailEvent {
  final String phone;

  PostApplyOpenPhoneCall(this.phone);
}

class PostdetailAcceptSubmitted extends PostapplydetailEvent {
  final String workerofservicecode;
  final String postCode;

  PostdetailAcceptSubmitted({this.workerofservicecode, this.postCode});
}
class PostApplyDetailCancelSubmitted extends PostapplydetailEvent {
  final String workerofservicecode;
  final String postCode;

  PostApplyDetailCancelSubmitted({this.workerofservicecode, this.postCode});
}
