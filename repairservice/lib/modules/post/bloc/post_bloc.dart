import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
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
    } else if (event is PostAddNewPage) {
      yield state.copyWith(images: <File>[], serviceCode: "", serviceText: "");
    } else if (event is PostAddImageMutiChanged) {
      yield* _mapPostAddImageMutiChangedToState(event, state);
    } else if (event is PostDeleteImageMutiChanged) {
      yield _mapPostDeleteImageMutiChangedToState(event, state);
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
    } else if (event is PostWorkerApplySubmitted) {
      yield* _mapPostWorkerApplySubmittedToState(event, state);
    }
  }

  _mapPostTitleChangedToState(PostTitleChanged event, PostState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value, status: Formz.validate([value, state.description]));
  }

  Stream<PostState> _mapPostFetched(PostFetched event, PostState state) async* {
    if (state.pageStatus == PostStatus.loadSuccess)
      yield state.copyWith(pageStatus: PostStatus.loadSuccess);
    yield state.copyWith(pageStatus: PostStatus.loading);
    try {
      var datas = await _postRepository.fetchPost(serviceCode: event.code);

      yield state.copyWith(pageStatus: PostStatus.loadSuccess, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostStatus.failure);
    }
  }

  Stream<PostState> _mapPostFetchedByPhone(
      PostFetchedByPhone event, PostState state) async* {
    if (state.pageStatus == PostStatus.loadSuccess)
      yield state.copyWith(pageStatus: PostStatus.loadSuccess);
    yield state.copyWith(pageStatus: PostStatus.loading);
    try {
      var datas = await _postRepository.fetchPostByPhone();

      yield state.copyWith(pageStatus: PostStatus.loadSuccess, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostStatus.failure);
    }
  }

  Stream<PostState> _mapPostRecently(
      PostRecently event, PostState state) async* {
    if (state.pageStatus == PostStatus.loadSuccess)
      yield state.copyWith(pageStatus: PostStatus.loadSuccess);
    yield state.copyWith(pageStatus: PostStatus.loading);
    try {
      var datas = await _postRepository.fetchRecentlyPost();

      yield state.copyWith(pageStatus: PostStatus.loadSuccess, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostStatus.failure);
    }
  }

  Stream<PostState> _mapPostAddImageMutiChangedToState(
      PostAddImageMutiChanged event, PostState state) async* {
    yield state.copyWith(fileStatus: FileStatus.close);
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: event.imageSource);
      if (pickedFile != null) {
        yield state.copyWith(
            images: List.of(state.images)..add(new File(pickedFile.path)),
            fileStatus: FileStatus.open);
      } else {
        yield state.copyWith(
          images: state.images,
        );
      }
    } on Exception catch (_) {
      yield state.copyWith(fileStatus: FileStatus.close);
    }
  }

  _mapPostDeleteImageMutiChangedToState(
      PostDeleteImageMutiChanged event, PostState state) {
    return state.copyWith(
        images: List.of(state.images)..removeAt(event.target),
        fileStatus: FileStatus.open);
  }

  Stream<PostState> _mapPostWorkerApplySubmittedToState(
      PostWorkerApplySubmitted event, PostState state) async* {
    yield state.copyWith(pageStatus: PostStatus.loading);
    try {
      var response =
          await _postRepository.workerApplyPost(postCode: event.code);
      if (response.statusCode == 200) {
        yield state.copyWith(pageStatus: PostStatus.sbumitSuccess);
      } else {
        yield state.copyWith(pageStatus: PostStatus.failure);
      }
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostStatus.failure);
    }
  }

  Stream<PostState> _mapPostSubmittedToState(
      PostCustomerSubmitted event, PostState state) async* {
    yield state.copyWith(pageStatus: PostStatus.loading);
    try {
      var response = await _postRepository.customerAddPost(
          serviceCode: state.serviceCode,
          title: state.title.value,
          address: state.address.value,
          description: state.description.value,
          files: state.images,
          finishAt: null,
          position: null,
          status: 0);
      if (response.statusCode == 200)
        yield state.copyWith(pageStatus: PostStatus.sbumitSuccess);
      else
        yield state.copyWith(pageStatus: PostStatus.failure);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostStatus.failure);
    }
  }
}
