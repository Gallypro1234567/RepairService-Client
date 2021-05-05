import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:repairservice/repository/home_repository/models/preferential_model.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:rxdart/rxdart.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeRepository homeRepository, PostRepository postRepository})
      : _homeRepository = homeRepository,
        _postRepository = postRepository,
        super(const HomeState());

  final HomeRepository _homeRepository;
  final PostRepository _postRepository;

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
    Stream<HomeEvent> events,
    TransitionFunction<HomeEvent, HomeState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFetched) {
      yield await _mapFetchedToState(state);
    } else if (event is HomeRefesh) {
      yield* _mapRefeshedToState(state);
    }
  }

  Future<HomeState> _mapFetchedToState(HomeState state) async {
    if (state.hasReachedMax) return state;

    try {
      if (state.status == HomeStatus.initial) {
        final userRole = await _homeRepository.getRole();
        final services = await _homeRepository.fetchService();
        final postRecently =
            await _postRepository.fetchRecentlyPost(start: 0, length: 5);
        return state.copyWith(
          status: HomeStatus.success,
          services: services,
          role: userRole.role,
          isCustomer: userRole.isCustomer,
          pagestatus: PageStatus.initial,
          hasReachedMax: postRecently.length < 5 ? true : false,
          postRecently: postRecently,
        );
      } else {
        final postRecently = await _postRepository.fetchRecentlyPost(
            start: state.postRecently.length, length: 5);
        return postRecently.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: HomeStatus.success,
                pagestatus: PageStatus.navigationPage,
                hasReachedMax: false,
                postRecently: List.of(state.postRecently)..addAll(postRecently),
              );
      }
    } on Exception catch (e) {
      return state.copyWith(status: HomeStatus.failure, message: e.toString());
    }
  }

  Stream<HomeState> _mapRefeshedToState(HomeState state) async* {
    yield state.copyWith(
      status: HomeStatus.loading,
    );
    try {
      final userRole = await _homeRepository.getRole();
      final services = await _homeRepository.fetchService();
      final postRecently =
          await _postRepository.fetchRecentlyPost(start: 0, length: 5);
      yield state.copyWith(
          status: HomeStatus.initial,
          services: services,
          role: userRole.role,
          hasReachedMax: postRecently.length < 5 ? true : false,
          postRecently: postRecently);
    } on Exception catch (e) {
      yield state.copyWith(status: HomeStatus.failure, message: e.toString());
    }
  }
}
