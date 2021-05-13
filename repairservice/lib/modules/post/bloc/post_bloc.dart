import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/modules/post/models/address.dart';
import 'package:repairservice/modules/post/models/description.dart';
import 'package:repairservice/modules/post/models/title.dart';

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
    } else if (event is PostAddNewPage)
      yield state.copyWith(images: <File>[], serviceCode: "", serviceText: "");
    else if (event is PostAddImageMutiChanged)
      yield* _mapPostAddImageMutiChangedToState(event, state);
    else if (event is PostDeleteImageMutiChanged)
      yield _mapPostDeleteImageMutiChangedToState(event, state);
    else if (event is PostServiceChanged)
      yield _mapPostServiceChangedToState(event, state);
    else if (event is PostAddressChanged)
      yield _mapPostAddressChangedToState(event, state);
    else if (event is PostTitleChanged)
      yield _mapPostTitleChangedToState(event, state);
    else if (event is PostDescriptionChanged)
      yield _mapPostDescriptionChangedToState(event, state);
    else if (event is PostCustomerSubmitted)
      yield* _mapPostSubmittedToState(event, state);
    else if (event is PostWorkerApplySubmitted)
      yield* _mapPostWorkerApplySubmittedToState(event, state);
  }
 
 _mapPostServiceChangedToState(PostServiceChanged event, PostState state) {
     
    return state.copyWith(
        serviceCode: event.code, serviceText: event.text, serviceInvalid: event.invalid);
  }

 _mapPostAddressChangedToState(PostAddressChanged event, PostState state) {
    final value = Address.dirty(event.value);
    return state.copyWith(
        address: value, formzstatus: Formz.validate([value, state.description, state.title]));
  }

  _mapPostTitleChangedToState(PostTitleChanged event, PostState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value, formzstatus: Formz.validate([value, state.description, state.address]));
  }

  _mapPostDescriptionChangedToState(
      PostDescriptionChanged event, PostState state) {
    final value = Description.dirty(event.value);
    return state.copyWith(
        description: value, formzstatus: Formz.validate([value, state.title, state.address]));
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
