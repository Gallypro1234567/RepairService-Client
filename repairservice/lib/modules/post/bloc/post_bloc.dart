import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repairservice/modules/post/models/address.dart';
import 'package:repairservice/modules/post/models/description.dart';
import 'package:repairservice/modules/post/models/title.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostState());
  final PostRepository _postRepository;
  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostInitial) {
      yield state.copyWith();
    } else if (event is PostFetched) {
      yield* _mapPostFetched(event, state);
    } else if (event is PostRecently) {
      yield* _mapPostRecently(event, state);
    } else if (event is PostFetchedByPhone) {
      yield* _mapPostFetchedByPhone(event, state);
    } else if (event is PostServiceChanged) {
      yield state.copyWith(serviceText: event.text, serviceCode: event.code);
    } else if (event is PostAddressChanged) {
      yield state.copyWith(address: Address.dirty(event.value));
    } else if (event is PostTitleChanged) {
      yield _mapPostTitleChangedToState(event, state);
    } else if (event is PostDescriptionChanged) {
      yield state.copyWith(description: Description.dirty(event.value));
    } else if (event is PostCustomerSubmitted) {
      yield* _mapPostSubmittedToState(event, state);
    }
  }

  _mapPostTitleChangedToState(PostTitleChanged event, PostState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value, status: Formz.validate([value, state.description]));
  }

  Stream<PostState> _mapPostFetched(PostFetched event, PostState state) async* {
    if (state.pageStatus == PageStatus.loadSuccess)
      yield state.copyWith(pageStatus: PageStatus.loadSuccess);
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var datas = await _postRepository.fetchPost(serviceCode: event.code);

      yield state.copyWith(pageStatus: PageStatus.loadSuccess, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }

  Stream<PostState> _mapPostSubmittedToState(
      PostCustomerSubmitted event, PostState state) async* {
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var response = await _postRepository.addPost(
          serviceCode: state.serviceCode,
          title: state.title.value,
          address: state.address.value,
          description: state.description.value,
          file: null,
          finishAt: null,
          position: null,
          status: 0);
      if (response.statusCode == 200)
        yield state.copyWith(pageStatus: PageStatus.sbumitSuccess);
      else
        yield state.copyWith(pageStatus: PageStatus.failure);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }

  Stream<PostState> _mapPostFetchedByPhone(
      PostFetchedByPhone event, PostState state) async* {
    if (state.pageStatus == PageStatus.loadSuccess)
      yield state.copyWith(pageStatus: PageStatus.loadSuccess);
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var datas = await _postRepository.fetchPostByPhone();

      yield state.copyWith(pageStatus: PageStatus.loadSuccess, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }

  Stream<PostState> _mapPostRecently(
      PostRecently event, PostState state) async* {
    if (state.pageStatus == PageStatus.loadSuccess)
      yield state.copyWith(pageStatus: PageStatus.loadSuccess);
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var datas = await _postRepository.fetchRecentlyPost();

      yield state.copyWith(pageStatus: PageStatus.loadSuccess, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }
}
