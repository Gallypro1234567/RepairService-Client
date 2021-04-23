import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';  
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'manager_event.dart';
part 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(ManagerState());
  final PostRepository _postRepository;
  @override
  Stream<ManagerState> mapEventToState(
    ManagerEvent event,
  ) async* {
    if (event is ManagerFetched) {
      yield* _mapManagerFetchedByPhone(event, state);
    }
  }

  Stream<ManagerState> _mapManagerFetchedByPhone(
      ManagerFetched event, ManagerState state) async* {
    if (state.pageStatus == PageStatus.success)
      yield state.copyWith(pageStatus: PageStatus.success);
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var datas = await _postRepository.fetchPostByPhone();

      yield state.copyWith(pageStatus: PageStatus.success, posts: datas);
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }
}
