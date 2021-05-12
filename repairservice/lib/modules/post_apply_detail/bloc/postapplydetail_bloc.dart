import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'postapplydetail_event.dart';
part 'postapplydetail_state.dart';

class PostapplydetailBloc
    extends Bloc<PostapplydetailEvent, PostapplydetailState> {
  PostapplydetailBloc(
      {PostRepository postRepository, UserRepository userRepository})
      : _postRepository = postRepository,
        _userRepository = userRepository,
        super(PostapplydetailState());
  final PostRepository _postRepository;
  final UserRepository _userRepository;
  @override
  Stream<PostapplydetailState> mapEventToState(
    PostapplydetailEvent event,
  ) async* {
    if (event is PostApplyDetailInitial)
      yield state.copyWith();
    else if (event is PostApplyDetailFetched)
      yield* _mapPostApplyDetailFetchedToState(event, state);
    else if (event is PostApplyOpenPhoneCall)
      yield* _mapPostApplyOpenDetailPhoneCallToState(event, state);
    else if (event is PostdetailAcceptSubmitted)
      yield* _mapPostdetailAcceptSubmittedToState(event, state);
    else if (event is PostApplyDetailCancelSubmitted)
      yield* _mapPostApplyDetailCancelSubmittedToState(event, state);
  }

  Stream<PostapplydetailState> _mapPostApplyDetailFetchedToState(
      PostApplyDetailFetched event, PostapplydetailState state) async* {
    yield state.copyWith(status: ApplyDetailStatus.loading);
    try {
      var data = await _userRepository.fetchWorkerDetail(
          phone: event.phone, wOfsCode: event.wofscode);

      yield state.copyWith(
        status: ApplyDetailStatus.success,
        postApply: data,
        postCode: event.postCode,
        wofscode: event.wofscode,
      );
    } on Exception catch (_) {
      yield state.copyWith(status: ApplyDetailStatus.failure);
    }
  }

  Stream<PostapplydetailState> _mapPostApplyOpenDetailPhoneCallToState(
      PostApplyOpenPhoneCall event, PostapplydetailState state) async* {
    try {
      await launch("tel: ${event.phone}");
    } on Exception catch (_) {
      yield state.copyWith(status: ApplyDetailStatus.failure);
    }
  }

  Stream<PostapplydetailState> _mapPostdetailAcceptSubmittedToState(
      PostdetailAcceptSubmitted event, PostapplydetailState state) async* {
    yield state.copyWith(status: ApplyDetailStatus.loading);
    try {
      var response = await _postRepository.customerAcceptPostApply(
          postcode: event.postCode,
          workerofservicecode: event.workerofservicecode,
          status: 2,
          poststatus: 1);
      if (response.statusCode == 200)
        yield state.copyWith(
          status: ApplyDetailStatus.acceptSubmitted,
        );
    } on Exception catch (_) {
      yield state.copyWith(status: ApplyDetailStatus.failure);
    }
  }

  Stream<PostapplydetailState> _mapPostApplyDetailCancelSubmittedToState(
      PostApplyDetailCancelSubmitted event, PostapplydetailState state) async* {
    yield state.copyWith(status: ApplyDetailStatus.loading);
    try {
      var response = await _postRepository.customerCancelPostApply(
        postcode: event.postCode,
        workerofservicecode: event.workerofservicecode,
      );
      if (response.statusCode == 200)
        yield state.copyWith(
          status: ApplyDetailStatus.cancelSubmitted,
        );
    } on Exception catch (_) {
      yield state.copyWith(status: ApplyDetailStatus.failure);
    }
  }
}
