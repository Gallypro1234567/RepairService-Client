import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

part 'postdetail_event.dart';
part 'postdetail_state.dart';

class PostdetailBloc extends Bloc<PostdetailEvent, PostdetailState> {
  PostdetailBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostdetailState());

  final PostRepository _postRepository;
  @override
  Stream<PostdetailState> mapEventToState(
    PostdetailEvent event,
  ) async* {
    if (event is PostdetailInitial) {
      yield state.copyWith();
    } else if (event is PostdetailFetched) {
      yield* _mapPostdetailFetchedToState(event, state);
    } else if (event is PostdetailWorkerApplySubmitted) {
      yield* _mapPostdetailWorkerApplySubmittedToState(event, state);
    } else if (event is PostdetailCheckWorker)
      yield* _mapPostdetailCheckWorkerToState(event, state);
  }

  Stream<PostdetailState> _mapPostdetailFetchedToState(
      PostdetailFetched event, PostdetailState state) async* {
    yield state.copyWith(status: PostDetailStatus.loading);
    try {
      var data = await _postRepository.fetchPostByCode(code: event.postCode);

      yield state.copyWith(
        status: PostDetailStatus.success,
        postCode: event.postCode,
        post: data,
      );
    } on Exception catch (_) {
      yield state.copyWith(status: PostDetailStatus.failure);
    }
  }

  
  Stream<PostdetailState> _mapPostdetailCheckWorkerToState(
      PostdetailCheckWorker event, PostdetailState state) async* {
    yield state.copyWith(status: PostDetailStatus.loading);
    try {
      int checkResponse;

      checkResponse =
          await _postRepository.checkApplybyWorker(postCode: event.postCode);

      yield state.copyWith(
          statusApply: checkResponse, status: PostDetailStatus.success);
    } on Exception catch (_) {
      yield state.copyWith(status: PostDetailStatus.failure);
    }
  }
  Stream<PostdetailState> _mapPostdetailWorkerApplySubmittedToState(
      PostdetailWorkerApplySubmitted event, PostdetailState state) async* {
    yield state.copyWith(status: PostDetailStatus.loading);
    try {
      var response = await _postRepository.workerApplyPost(
          postCode: state.postCode, status: 1);

      if (response.statusCode == 200) {
        yield state.copyWith(
          status: PostDetailStatus.submitted,
        );
      } else {
        yield state.copyWith(status: PostDetailStatus.failure);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: PostDetailStatus.failure);
    }
  }

}
