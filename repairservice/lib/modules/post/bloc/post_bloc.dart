import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/modules/post/models/address.dart';
import 'package:repairservice/modules/post/models/description.dart';
import 'package:repairservice/modules/post/models/title.dart';

import 'package:repairservice/repository/post_repository/models/city_model.dart';

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
      yield state.copyWith(
        pageStatus: PostStatus.none,
        message: "",
        images: <File>[],
        serviceCode: "",
        serviceText: "",
        districtText: "",
        cityText: "",
        wardText: "",
        serviceInvalid: false,
        cityInvalid: false,
        districtInvalid: false,
        wardInvalid: false,
      );
    else if (event is PostAddImageMutiChanged)
      yield* _mapPostAddImageMutiChangedToState(event, state);
    else if (event is PostDeleteImageMutiChanged)
      yield _mapPostDeleteImageMutiChangedToState(event, state);
    else if (event is PostServiceChanged)
      yield _mapPostServiceChangedToState(event, state);
    else if (event is PostCityFetched)
      yield* _mapPostCityFetchedToState(event, state);
    else if (event is PostDistrictFetched)
      yield* _mapPostDistrictFetchedToState(event, state);
    else if (event is PostWardFetched)
      yield* _mapPostWardFetchedToState(event, state);
    else if (event is PostCityChanged)
      yield _mapPostCityChangedToState(event, state);
    else if (event is PostDistrictChanged)
      yield _mapPostDistrictChangedToState(event, state);
    else if (event is PostWardChanged)
      yield _mapPostWardChangedToState(event, state);
    else if (event is PostTitleChanged)
      yield _mapPostTitleChangedToState(event, state);
    else if (event is PostDescriptionChanged)
      yield _mapPostDescriptionChangedToState(event, state);
    else if (event is PostCustomerSubmitted)
      yield* _mapPostSubmittedToState(event, state);
    else if (event is PostWorkerApplySubmitted)
      yield* _mapPostWorkerApplySubmittedToState(event, state);
  }

  _mapPostWardChangedToState(PostWardChanged event, PostState state) {
    return state.copyWith(
        wardId: event.id, wardText: event.text, wardInvalid: event.invalid);
  }

  _mapPostDistrictChangedToState(PostDistrictChanged event, PostState state) {
    return state.copyWith(
        districtId: event.id,
        districtText: event.text,
        districtInvalid: event.invalid);
  }

  _mapPostCityChangedToState(PostCityChanged event, PostState state) {
    return state.copyWith(
        cityId: event.id, cityText: event.text, cityInvalid: event.invalid);
  }

  _mapPostServiceChangedToState(PostServiceChanged event, PostState state) {
    return state.copyWith(
        serviceCode: event.code,
        serviceText: event.text,
        serviceInvalid: event.invalid);
  }

  _mapPostTitleChangedToState(PostTitleChanged event, PostState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value,
        formzstatus: Formz.validate([value, state.description, state.address]));
  }

  _mapPostDescriptionChangedToState(
      PostDescriptionChanged event, PostState state) {
    final value = Description.dirty(event.value);
    return state.copyWith(
        description: value,
        formzstatus: Formz.validate([value, state.title, state.address]));
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
          address:
              "${state.wardText}, ${state.districtText}, ${state.cityText}",
          cityId: state.cityId.toString(),
          districtId: state.districtId.toString(),
          wardId: state.wardId.toString(),
          description: state.description.value,
          files: state.images,
          finishAt: null,
          status: 0);
      if (response.statusCode == 200)
        yield state.copyWith(pageStatus: PostStatus.sbumitSuccess);
      else {
        var jsons = json.decode(response.body);

        yield state.copyWith(
            pageStatus: PostStatus.failure,
            message: jsons["Message"] as String);
      }
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostStatus.failure);
    }
  }

  Stream<PostState> _mapPostCityFetchedToState(
      PostCityFetched event, PostState state) async* {
    if (state.cities.length > 0)
      yield state.copyWith(positionStatus: PositionStatus.success);
    else {
      yield state.copyWith(positionStatus: PositionStatus.loading);
      try {
        var listData = await _postRepository.fetchCities();

        yield state.copyWith(
            positionStatus: PositionStatus.success, cities: listData);
      } on Exception catch (_) {
        yield state.copyWith(positionStatus: PositionStatus.failure);
      }
    }
  }

  Stream<PostState> _mapPostDistrictFetchedToState(
      PostDistrictFetched event, PostState state) async* {
    yield state.copyWith(positionStatus: PositionStatus.loading);
    try {
      var listData = await _postRepository.fetchDistrictbyCityId(
          id: event.cityid.toString());

      yield state.copyWith(
          positionStatus: PositionStatus.success, districts: listData);
    } on Exception catch (_) {
      yield state.copyWith(positionStatus: PositionStatus.failure);
    }
  }

  Stream<PostState> _mapPostWardFetchedToState(
      PostWardFetched event, PostState state) async* {
    yield state.copyWith(positionStatus: PositionStatus.loading);
    try {
      var listData = await _postRepository.fetchWardbyDisctrictId(
          id: event.districtId.toString());

      yield state.copyWith(
          positionStatus: PositionStatus.success, wards: listData);
    } on Exception catch (_) {
      yield state.copyWith(positionStatus: PositionStatus.failure);
    }
  }
}
