import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart'; 
import 'package:http/http.dart' as http;
import 'package:repairservice/modules/home/models/service_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.httpClient) : super(const HomeState());

  final http.Client httpClient;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<HomeState> _mapPostFetchedToState(HomeState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == HomeStatus.initial) { 
     
        final services = await _fetchPosts();
        return state.copyWith(
          status: HomeStatus.success,
          services: services,
          hasReachedMax: false,
        );
      }
      final services = await _fetchPosts(state.services.length);
      return services.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: HomeStatus.success,
              services: List.of(state.services)..addAll(services),
              hasReachedMax: false,
            );
    } on Exception catch (e) {
      return state.copyWith(status: HomeStatus.failure, message: e.toString());
    }
  }

  Future<List<Service>> _fetchPosts([int startIndex = 0]) async {
    
    final response = await httpClient
        .get(Uri.https('jsonplaceholder.typicode.com', '/posts'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Service(
          id: json['Id'] as String,
          name: json['title'] as String,
        );
      }).toList();
    }
    throw Exception(response.statusCode);
  }
}
