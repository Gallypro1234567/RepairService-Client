import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:repairservice/repository/home_repository/models/preferential_model.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const HomeState());

  final HomeRepository _homeRepository;
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFetched) {
      yield* _mapPostFetchedToState(state);
    } else if (event is HomeRefesh) {
      yield* _mapRefeshedToState(state);
    }
  }

  Stream<HomeState> _mapPostFetchedToState(HomeState state) async* {
    if (state.hasReachedMax) yield state;

    try {
      final services = await _homeRepository.fetchService();
      final preferentials = await _homeRepository.fetchPreferential();
      yield state.copyWith(
        status: HomeStatus.success,
        services: services,
        preferentials: preferentials,
        hasReachedMax: false,
      );
    } on Exception catch (e) {
      yield state.copyWith(status: HomeStatus.failure, message: e.toString());
    }
  }

  Stream<HomeState> _mapRefeshedToState(HomeState state) async* {
    yield state.copyWith(status: HomeStatus.loading);
    try {
      final role = await _homeRepository.getRole();
      final services = await _homeRepository.fetchService();
      final preferentials = await _homeRepository.fetchPreferential();
      yield state.copyWith(
        status: HomeStatus.success,
        preferentials: preferentials,
        services: services,
        hasReachedMax: false,
        role: role,
      );
    } on Exception catch (e) {
      yield state.copyWith(status: HomeStatus.failure, message: e.toString());
    }
  }
  // Future<HomeState> _mapPostFetchedToState(HomeState state) async {
  //   if (state.hasReachedMax) return state;
  //   try {
  //     if (state.status == HomeStatus.initial) {

  //       final services = await _fetchPosts();
  //       return state.copyWith(
  //         status: HomeStatus.success,
  //         services: services,
  //         hasReachedMax: false,
  //       );
  //     }
  //     final services = await _fetchPosts(state.services.length);
  //     return services.isEmpty
  //         ? state.copyWith(hasReachedMax: true)
  //         : state.copyWith(
  //             status: HomeStatus.success,
  //             services: List.of(state.services)..addAll(services),
  //             hasReachedMax: false,
  //           );
  //   } on Exception catch (e) {
  //     return state.copyWith(status: HomeStatus.failure, message: e.toString());
  //   }
  // }

  // Future<List<Service>> _fetchPosts([int startIndex = 0]) async {

  //   final response = await httpClient
  //       .get(Uri.https('jsonplaceholder.typicode.com', '/posts'));

  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     return body.map((dynamic json) {
  //       return Service(
  //         id: json['Id'] as String,
  //         name: json['title'] as String,
  //       );
  //     }).toList();
  //   }
  //   throw Exception(response.statusCode);
  // }
}
