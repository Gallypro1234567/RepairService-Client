import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/modules/post_update/models/address.dart';
import 'package:repairservice/modules/post_update/models/description.dart';
import 'package:repairservice/modules/post_update/models/title.dart';
import 'package:repairservice/repository/post_repository/models/city_model.dart';
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
    if (event is PostUpdateInitial)
      yield state.copyWith();
    else if (event is PostUpdateFetched)
      yield* _mapPostUpdateFetched(event, state);
    else if (event is PostUpdateAddNewPage)
      yield state.copyWith(images: <File>[], serviceCode: "", serviceText: "");
    // Position Fetched
    else if (event is PostUpdateCityFetched)
      yield* _mapPostCityFetchedToState(event, state);
    else if (event is PostUpdateDistrictFetched)
      yield* _mapPostDistrictFetchedToState(event, state);
    else if (event is PostUpdateWardFetched)
      yield* _mapPostWardFetchedToState(event, state);
    // Field
    else if (event is PostUpdateCityChanged)
      yield _mapPostCityChangedToState(event, state);
    else if (event is PostUpdateDistrictChanged)
      yield _mapPostDistrictChangedToState(event, state);
    else if (event is PostUpdateWardChanged)
      yield _mapPostWardChangedToState(event, state);
    else if (event is PostUpdateAddImageMutiChanged)
      yield* _mapPostUpdateAddImageMutiChangedToState(event, state);
    else if (event is PostUpdateDeleteImageMutiChanged)
      yield _mapPostUpdateDeleteImageMutiChangedToState(event, state);
    else if (event is PostUpdateServiceChanged)
      yield _mapPostUpdateServiceChangedToState(event, state);
    else if (event is PostUpdateTitleChanged)
      yield _mapPostUpdateTitleChangedToState(event, state);
    else if (event is PostUpdateDescriptionChanged)
      yield _mapPostUpdateDescriptionChangedToState(event, state);
    else if (event is PostUpdateCustomerSubmitted)
      yield* _mapPostUpdateSubmittedToState(event, state);
  }

  Stream<PostUpdateState> _mapPostCityFetchedToState(
      PostUpdateCityFetched event, PostUpdateState state) async* {
    if (state.cities.length > 0)
      yield state.copyWith(positionUpdateStatus: PositionUpdateStatus.success);
    else {
      yield state.copyWith(positionUpdateStatus: PositionUpdateStatus.loading);
      try {
        var listData = await _postRepository.fetchCities();

        yield state.copyWith(
            positionUpdateStatus: PositionUpdateStatus.success,
            cities: listData);
      } on Exception catch (_) {
        yield state.copyWith(
            positionUpdateStatus: PositionUpdateStatus.failure);
      }
    }
  }

  Stream<PostUpdateState> _mapPostDistrictFetchedToState(
      PostUpdateDistrictFetched event, PostUpdateState state) async* {
    yield state.copyWith(positionUpdateStatus: PositionUpdateStatus.loading);
    try {
      var listData = await _postRepository.fetchDistrictbyCityId(
          id: event.cityid.toString());

      yield state.copyWith(
          positionUpdateStatus: PositionUpdateStatus.success,
          districts: listData);
    } on Exception catch (_) {
      yield state.copyWith(positionUpdateStatus: PositionUpdateStatus.failure);
    }
  }

  Stream<PostUpdateState> _mapPostWardFetchedToState(
      PostUpdateWardFetched event, PostUpdateState state) async* {
    yield state.copyWith(positionUpdateStatus: PositionUpdateStatus.loading);
    try {
      var listData = await _postRepository.fetchWardbyDisctrictId(
          id: event.districtId.toString());

      yield state.copyWith(
          positionUpdateStatus: PositionUpdateStatus.success, wards: listData);
    } on Exception catch (_) {
      yield state.copyWith(positionUpdateStatus: PositionUpdateStatus.failure);
    }
  }

  _mapPostWardChangedToState(
      PostUpdateWardChanged event, PostUpdateState state) {
    return state.copyWith(
        wardId: event.id, wardText: event.text, wardInvalid: event.invalid);
  }

  _mapPostDistrictChangedToState(
      PostUpdateDistrictChanged event, PostUpdateState state) {
    return state.copyWith(
        districtId: event.id,
        districtText: event.text,
        districtInvalid: event.invalid);
  }

  _mapPostCityChangedToState(
      PostUpdateCityChanged event, PostUpdateState state) {
    return state.copyWith(
        cityId: event.id, cityText: event.text, cityInvalid: event.invalid);
  }

  _mapPostUpdateServiceChangedToState(
      PostUpdateServiceChanged event, PostUpdateState state) {
    return state.copyWith(
        serviceCode: event.code,
        serviceText: event.text,
        serviceInvalid: event.invalid);
  }

  _mapPostUpdateTitleChangedToState(
      PostUpdateTitleChanged event, PostUpdateState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value,
        status: Formz.validate([value, state.description, state.address]));
  }

  _mapPostUpdateDescriptionChangedToState(
      PostUpdateDescriptionChanged event, PostUpdateState state) {
    final value = Description.dirty(event.value);
    return state.copyWith(
        description: value,
        status: Formz.validate([value, state.title, state.address]));
  }

  Stream<PostUpdateState> _mapPostUpdateFetched(
      PostUpdateFetched event, PostUpdateState state) async* {
    yield state.copyWith(pageStatus: PostUpdateStatus.loading);
    try {
      var data = await _postRepository.fetchPostByCode(code: event.code);
      String cityText = "";
      String districtText = "";
      String wardText = "";
      if (data.address != null) {
        if (data.address.toString().isNotEmpty) {
          List<String> list = data.address.split(', ');
          if (list.length == 3) {
            wardText = list[0];
            districtText = list[1];
            cityText = list[2];
          }
        }
      }
      yield state.copyWith(
          pageStatus: PostUpdateStatus.loadSuccess,
          images: data.imageUrls,
          serviceCode: data.serviceCode,
          serviceText: data.serviceText,
          address: Address.dirty(data.address),
          cityText: cityText,
          districtText: districtText,
          wardText: wardText,
          cityId: data.cityId,
          districtId: data.districtId,
          wardId: data.wardId,
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
          address:
              "${state.wardText}, ${state.districtText}, ${state.cityText}",
          cityId: state.cityId.toString(),
          districtId: state.districtId.toString(),
          wardId: state.wardId.toString(),
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
