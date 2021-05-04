import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/modules/post_update/models/address.dart';
import 'package:repairservice/modules/post_update/models/description.dart';
import 'package:repairservice/modules/post_update/models/title.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'postupdate_event.dart';
part 'postupdate_state.dart';

class PostUpdateBloc extends Bloc<PostUpdateEvent, PostUpdateState> {
  PostUpdateBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostUpdateState());
  final PostRepository _postRepository;
  @override
  Stream<PostUpdateState> mapEventToState(
    PostUpdateEvent event,
  ) async* {
    if (event is PostUpdateInitial) {
      yield state.copyWith();
    } else if (event is PostUpdateFetched) {
      yield* _mapPostUpdateFetched(event, state);
    } else if (event is PostUpdateAddNewPage) {
      yield state.copyWith(images: <File>[], serviceCode: "", serviceText: "");
    } else if (event is PostUpdateAddImageMutiChanged) {
      yield* _mapPostUpdateAddImageMutiChangedToState(event, state);
    } else if (event is PostUpdateDeleteImageMutiChanged) {
      yield _mapPostUpdateDeleteImageMutiChangedToState(event, state);
    } else if (event is PostUpdateServiceChanged) {
      yield state.copyWith(serviceText: event.text, serviceCode: event.code);
    } else if (event is PostUpdateAddressChanged) {
      yield state.copyWith(address: Address.dirty(event.value));
    } else if (event is PostUpdateTitleChanged) {
      yield _mapPostUpdateTitleChangedToState(event, state);
    } else if (event is PostUpdateDescriptionChanged) {
      yield state.copyWith(description: Description.dirty(event.value));
    } else if (event is PostUpdateCustomerSubmitted) {
      yield* _mapPostUpdateSubmittedToState(event, state);
    }
  }

  _mapPostUpdateTitleChangedToState(
      PostUpdateTitleChanged event, PostUpdateState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value, status: Formz.validate([value, state.description]));
  }

  Stream<PostUpdateState> _mapPostUpdateFetched(
      PostUpdateFetched event, PostUpdateState state) async* {
    yield state.copyWith(pageStatus: PostUpdateStatus.loading);
    try {
      var data = await _postRepository.fetchPostByCode(code: event.code);

      yield state.copyWith(
          pageStatus: PostUpdateStatus.loadSuccess,
          images: data.imageUrls,
          serviceCode: data.serviceCode,
          serviceText: data.serviceText,
          address: Address.dirty(data.address),
          description: Description.dirty(data.desciption),
          title: Title.dirty(data.title),
          code: data.code);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostUpdateStatus.failure);
    }
  }

  Stream<PostUpdateState> _mapPostUpdateAddImageMutiChangedToState(
      PostUpdateAddImageMutiChanged event, PostUpdateState state) async* {
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

  _mapPostUpdateDeleteImageMutiChangedToState(
      PostUpdateDeleteImageMutiChanged event, PostUpdateState state) {
    return state.copyWith(
        images: List.of(state.images)..removeAt(event.target),
        fileStatus: FileStatus.open);
  }

  Stream<PostUpdateState> _mapPostUpdateSubmittedToState(
      PostUpdateCustomerSubmitted event, PostUpdateState state) async* {
    yield state.copyWith(pageStatus: PostUpdateStatus.loading);
    try {
      var response = await _postRepository.customerUpdatePost(
          code: state.code,
          serviceCode: state.serviceCode,
          title: state.title.value,
          address: state.address.value,
          description: state.description.value,
          files: state.images,
          finishAt: null,
          position: null,
          status: 0);
      if (response.statusCode == 200)
        yield state.copyWith(pageStatus: PostUpdateStatus.sbumitSuccess);
      else
        yield state.copyWith(pageStatus: PostUpdateStatus.failure);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostUpdateStatus.failure);
    }
  }
}
