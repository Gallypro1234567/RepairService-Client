import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/city_model.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(SearchState());
  final PostRepository _postRepository;
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchInitial)
      yield state.copyWith();
    else if (event is SearchFetched)
      yield* _mapPostFetched(event, state);
    else if (event is SearchCityFetched)
      yield* _mapSearchCityFetchedToState(event, state);
    else if (event is SearchDistrictFetched)
      yield* _mapSearchDistrictFetchedToState(event, state);
    else if (event is SearchWardFetched)
      yield* _mapSearchWardFetchedToState(event, state);
    else if (event is SearchCitySelectChanged)
      yield state.copyWith(cityQuery: event.cityTitle, cityId: event.cityId);
    else if (event is SearchDistrictSelectChanged)
      yield state.copyWith(
          districtQuery: event.districtText, districtId: event.districtId);
  }

  Stream<SearchState> _mapPostFetched(
      SearchFetched event, SearchState state) async* {
    if (state.pageStatus == SearchStatus.loadSuccess)
      yield state.copyWith(pageStatus: SearchStatus.loadSuccess);
    yield state.copyWith(pageStatus: SearchStatus.loading);
    try {
      var datas = await _postRepository.fetchPost(
          search: event.search,
          serviceCode: event.code,
          cityId: state.cityId.toString(),
          districtId: state.districtId.toString());

      yield state.copyWith(
          pageStatus: SearchStatus.loadSuccess,
          posts: datas,
          searchString: event.search,
          serviceCode: event.code);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: SearchStatus.failure);
    }
  }

  Stream<SearchState> _mapSearchCityFetchedToState(
      SearchCityFetched event, SearchState state) async* {
    if (state.cities.length > 0)
      yield state.copyWith(postGetPositionStatus: SearchPositionStatus.success);
    else {
      yield state.copyWith(postGetPositionStatus: SearchPositionStatus.loading);
      try {
        var listData = await _postRepository.fetchCities();

        yield state.copyWith(
          postGetPositionStatus: SearchPositionStatus.success,
          cities: listData,
        );
      } on Exception catch (_) {
        yield state.copyWith(
            postGetPositionStatus: SearchPositionStatus.failure);
      }
    }
  }

  Stream<SearchState> _mapSearchDistrictFetchedToState(
      SearchDistrictFetched event, SearchState state) async* {
    yield state.copyWith(postGetPositionStatus: SearchPositionStatus.loading);
    try {
      var listData = await _postRepository.fetchDistrictbyCityId(
          provinceId: event.cityId.toString());

      yield state.copyWith(
          postGetPositionStatus: SearchPositionStatus.success,
          distrists: listData);
    } on Exception catch (_) {
      yield state.copyWith(postGetPositionStatus: SearchPositionStatus.failure);
    }
  }

  Stream<SearchState> _mapSearchWardFetchedToState(
      SearchWardFetched event, SearchState state) async* {
    yield state.copyWith(postGetPositionStatus: SearchPositionStatus.loading);
    try {
      var listData = await _postRepository.fetchWardbyDisctrictId(
          districtId: event.districtId.toString(),
          provinceId: event.provinceId.toString());

      yield state.copyWith(
          postGetPositionStatus: SearchPositionStatus.success, wards: listData);
    } on Exception catch (_) {
      yield state.copyWith(postGetPositionStatus: SearchPositionStatus.failure);
    }
  }
}
