import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:repairservice/repository/post_repository/models/city_model.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'postgetlist_event.dart';
part 'postgetlist_state.dart';

class PostgetlistBloc extends Bloc<PostgetlistEvent, PostgetlistState> {
  PostgetlistBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostgetlistState());

  final PostRepository _postRepository;
  @override
  Stream<PostgetlistState> mapEventToState(
    PostgetlistEvent event,
  ) async* {
    if (event is PostgetlistInitial)
      yield state.copyWith();
    else if (event is PostgetlistFetched)
      yield* _mapPostFetched(event, state);
    else if (event is PostgetlistCityFetched)
      yield* _mapPostgetlistCityFetchedToState(event, state);
    else if (event is PostgetlistDistrictFetched)
      yield* _mapPostgetlistDistrictFetchedToState(event, state);
    else if (event is PostgetlistWardFetched)
      yield* _mapPostgetlistWardFetchedToState(event, state);
    else if (event is PostgetlistCitySelectChanged)
      yield state.copyWith(cityQuery: event.cityTitle, cityId: event.cityId);
    else if (event is PostgetlistDistrictSelectChanged)
      yield state.copyWith(
          districtQuery: event.districtText, districtId: event.districtId);
  }

  Stream<PostgetlistState> _mapPostFetched(
      PostgetlistFetched event, PostgetlistState state) async* {
    if (state.pageStatus == PostGetStatus.loadSuccess)
      yield state.copyWith(pageStatus: PostGetStatus.loadSuccess);
    yield state.copyWith(pageStatus: PostGetStatus.loading);
    try {
      var datas = await _postRepository.fetchPost(
          serviceCode: event.code,
          cityId: state.cityId.toString(),
          districtId: state.districtId.toString());

      yield state.copyWith(
          pageStatus: PostGetStatus.loadSuccess,
          posts: datas,
          serviceCode: event.code);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PostGetStatus.failure);
    }
  }

  Stream<PostgetlistState> _mapPostgetlistCityFetchedToState(
      PostgetlistCityFetched event, PostgetlistState state) async* {
    if (state.cities.length > 0)
      yield state.copyWith(
          postGetPositionStatus: PostGetPositionStatus.success);
    else {
      yield state.copyWith(
          postGetPositionStatus: PostGetPositionStatus.loading);
      try {
        var listData = await _postRepository.fetchCities();

        yield state.copyWith(
          postGetPositionStatus: PostGetPositionStatus.success,
          cities: listData,
        );
      } on Exception catch (_) {
        yield state.copyWith(postGetPositionStatus: PostGetPositionStatus.failure);
      }
    }
  }

  Stream<PostgetlistState> _mapPostgetlistDistrictFetchedToState(
      PostgetlistDistrictFetched event, PostgetlistState state) async* {
    yield state.copyWith(postGetPositionStatus: PostGetPositionStatus.loading);
    try {
      var listData = await _postRepository.fetchDistrictbyCityId(
          provinceId: event.cityId.toString());

      yield state.copyWith(
          postGetPositionStatus: PostGetPositionStatus.success, distrists: listData);
    } on Exception catch (_) {
      yield state.copyWith(postGetPositionStatus: PostGetPositionStatus.failure);
    }
  }

  Stream<PostgetlistState> _mapPostgetlistWardFetchedToState(
      PostgetlistWardFetched event, PostgetlistState state) async* {
    yield state.copyWith(postGetPositionStatus: PostGetPositionStatus.loading);
    try {
      var listData = await _postRepository.fetchWardbyDisctrictId(
          districtId: event.districtId.toString(),
          provinceId: event.provinceId.toString()
          );

      yield state.copyWith(
          postGetPositionStatus: PostGetPositionStatus.success, wards: listData);
    } on Exception catch (_) {
      yield state.copyWith(postGetPositionStatus: PostGetPositionStatus.failure);
    }
  }
}
