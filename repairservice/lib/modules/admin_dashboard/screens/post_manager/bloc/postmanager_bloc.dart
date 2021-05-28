import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'postmanager_event.dart';
part 'postmanager_state.dart';

class PostmanagerBloc extends Bloc<PostmanagerEvent, PostmanagerState> {
  PostmanagerBloc(
      {DashboardRepository dashboardRepository, PostRepository postRepository})
      : _dashboardRepository = dashboardRepository,
        _postRepository = postRepository,
        super(PostmanagerState());
  final DashboardRepository _dashboardRepository;
  final PostRepository _postRepository;
  @override
  Stream<PostmanagerState> mapEventToState(
    PostmanagerEvent event,
  ) async* {
    if (event is PostmanagerInitial)
      yield state.copyWith();
    else if (event is PostmanagerFetched)
      yield* _mapPostmanagerFetchedToState(event, state);
    else if (event is PostmanagerApproval)
      yield* _mapPostmanagerApprovalToState(event, state);
  }

  Stream<PostmanagerState> _mapPostmanagerFetchedToState(
      PostmanagerFetched event, PostmanagerState state) async* {
    yield state.copyWith(status: PostManagerStatus.loading);
    try {
      var posts = await _postRepository.fetchPost(
          serviceCode: "",
          cityId: "-1",
          districtId: "-1",
          status: -2,
          approval: -2);
      yield state.copyWith(
        status: PostManagerStatus.success,
        posts: posts,
      );
    } on Exception catch (_) {
      yield state.copyWith(status: PostManagerStatus.failure);
    }
  }

  Stream<PostmanagerState> _mapPostmanagerApprovalToState(
      PostmanagerApproval event, PostmanagerState state) async* {}
}
