import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'postapply_event.dart';
part 'postapply_state.dart';

class PostapplyBloc extends Bloc<PostapplyEvent, PostapplyState> {
  PostapplyBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostapplyState());
  final PostRepository _postRepository;
  @override
  Stream<PostapplyState> mapEventToState(
    PostapplyEvent event,
  ) async* {
    if (event is PostApplyInitial)
      yield state.copyWith();
    else if (event is PostapplyFetched)
      yield* _mapPostapplyFetchedToState(event, state);
    else if (event is PostApplyOpenPhoneCall)
      yield* _mapPostApplyOpenPhoneCallToState(event, state);
  }

  Stream<PostapplyState> _mapPostapplyFetchedToState(
      PostapplyFetched event, PostapplyState state) async* {
    yield state.copyWith(status: ApplyStatus.loading);
    try {
      var data =
          await _postRepository.fetchPostApplyByCode(postCode: event.postCode);

      yield state.copyWith(
        status: ApplyStatus.success,
        postApply: data,
      );
    } on Exception catch (_) {
      yield state.copyWith(status: ApplyStatus.failure);
    }
  }

  Stream<PostapplyState> _mapPostApplyOpenPhoneCallToState(
      PostApplyOpenPhoneCall event, PostapplyState state) async* {
    yield state.copyWith(status: ApplyStatus.loading);
    try {
      await launch("tel: ${event.phone}"); 
      yield state.copyWith(
        status: ApplyStatus.success,
      );
    } on Exception catch (_) {
      yield state.copyWith(status: ApplyStatus.failure);
    }
  }
}
