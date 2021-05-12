import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/post_detail_pefect.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'postdetailperfect_event.dart';
part 'postdetailperfect_state.dart';

class PostdetailperfectBloc
    extends Bloc<PostdetailperfectEvent, PostdetailperfectState> {
  PostdetailperfectBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostdetailperfectState());

  final PostRepository _postRepository;
  @override
  Stream<PostdetailperfectState> mapEventToState(
    PostdetailperfectEvent event,
  ) async* {
    if (event is PostdetailperfectInitial)
      yield state.copyWith();
    else if (event is PostdetailperfectFetched)
      yield* _mapPostdetailperfectFetchedToState(event, state);
    else if (event is PostdetailperfectWorkerSubmited)
      yield* _mapPostdetailperfectSubmitedToState(event, state);
    else if (event is PostdetailWorkerCancelSubmited)
      yield* _mapPostdetailCancelSubmitedToState(event, state);
    else if (event is PostdetailPerfectCustomerSubmited)
      yield* _mapPostdetailPerfectCustomerSubmitedToState(event, state);
  }

  Stream<PostdetailperfectState> _mapPostdetailperfectFetchedToState(
      PostdetailperfectFetched event, PostdetailperfectState state) async* {
    yield state.copyWith(status: PostPerfectStatus.loading);
    try {
      var data =
          await _postRepository.fetchPostPerfect(postCode: event.postCode);

      yield state.copyWith(
        status: PostPerfectStatus.loadsuccess,
        isCustomer: event.isCustomer,
        postCode: event.postCode,
        post: data,
      );
    } on Exception catch (_) {
      yield state.copyWith(status: PostPerfectStatus.failure);
    }
  }

  Stream<PostdetailperfectState> _mapPostdetailperfectSubmitedToState(
      PostdetailperfectWorkerSubmited event,
      PostdetailperfectState state) async* {
    yield state.copyWith(status: PostPerfectStatus.loading);
    try {
      var response = await _postRepository.workerPostApplyFinish(
          postcode: state.post.postCode,
          workerofservicecode: state.post.wofsCode,
          applystatus: 3,
          poststatus: 2);

      if (response.statusCode == 200)
        yield state.copyWith(
          status: PostPerfectStatus.perfectSubmitted,
        );
      else
        yield state.copyWith(
          status: PostPerfectStatus.failure,
        );
    } on Exception catch (_) {
      yield state.copyWith(status: PostPerfectStatus.failure);
    }
  }

  Stream<PostdetailperfectState> _mapPostdetailCancelSubmitedToState(
      PostdetailWorkerCancelSubmited event,
      PostdetailperfectState state) async* {
    yield state.copyWith(status: PostPerfectStatus.loading);
    try {
      var response = await _postRepository.workerPostApplyFinishCancel(
          postcode: state.post.postCode,
          workerofservicecode: state.post.wofsCode,
          applystatus: 2,
          poststatus: 1);
      if (response.statusCode == 200)
        yield state.copyWith(
          status: PostPerfectStatus.perfectSubmitted,
        );
      else
        yield state.copyWith(
          status: PostPerfectStatus.failure,
        );
    } on Exception catch (_) {
      yield state.copyWith(status: PostPerfectStatus.failure);
    }
  }

  Stream<PostdetailperfectState> _mapPostdetailPerfectCustomerSubmitedToState(
      PostdetailPerfectCustomerSubmited event,
      PostdetailperfectState state) async* {
    yield state.copyWith(status: PostPerfectStatus.loading);
    try {
      var response = await _postRepository.workerPostApplyFinishCancel(
          postcode: state.post.postCode,
          workerofservicecode: state.post.wofsCode,
          applystatus: 4,
          poststatus: 3);
      if (response.statusCode == 200)
        yield state.copyWith(
          status: PostPerfectStatus.perfectSubmitted,
        );
      else
        yield state.copyWith(
          status: PostPerfectStatus.failure,
        );
    } on Exception catch (_) {
      yield state.copyWith(status: PostPerfectStatus.failure);
    }
  }
}
