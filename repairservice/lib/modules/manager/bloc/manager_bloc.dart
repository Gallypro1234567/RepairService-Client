import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:url_launcher/url_launcher.dart';

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
    if (event is ManagerInitial)
      yield state.copyWith(pageStatus: PageStatus.none, posts: <Post>[]);
    else if (event is ManagerFetched)
      yield* _mapManagerFetchedByPhone(event, state);
    else if (event is ManagerCustomerDeletePost)
      yield* _mapManagerCustomerDeletePostToState(event, state);
    else if (event is ManagerWorkerDeleteApply)
      yield* _mapManagerWorkerDeleteApplyToState(event, state);
    else if (event is ManagerOpenPhoneCall)
      yield* _mapManagerOpenPhoneCallToState(event, state);
  }

  Stream<ManagerState> _mapManagerOpenPhoneCallToState(
      ManagerOpenPhoneCall event, ManagerState state) async* {
    try {
      await launch("tel: ${event.phone}");
    } on Exception catch (_) {}
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

  Stream<ManagerState> _mapManagerCustomerDeletePostToState(
      ManagerCustomerDeletePost event, ManagerState state) async* {
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var response =
          await _postRepository.deletePostByCustomer(postCode: event.postCode);

      if (response.statusCode == 200)
        yield state.copyWith(
          pageStatus: PageStatus.deleteSuccess,
        );
      else
        yield state.copyWith(
          pageStatus: PageStatus.failure,
        );
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }

  Stream<ManagerState> _mapManagerWorkerDeleteApplyToState(
      ManagerWorkerDeleteApply event, ManagerState state) async* {
    yield state.copyWith(pageStatus: PageStatus.loading);
    try {
      var response = await _postRepository.deletePostApplyByWorker(
          postCode: event.postCode);

      if (response.statusCode == 200) {
        await _postRepository.sendNotification(
            tilte: "Thông báo ứng tuyển",
            content: "đã hủy ứng tuyển",
            receiveBy: event.customerPhone,
            postCode: event.postCode,
            status: 0,
            type: 2);
        yield state.copyWith(
          pageStatus: PageStatus.deleteSuccess,
        );
      } else
        yield state.copyWith(
          pageStatus: PageStatus.failure,
        );
    } on Exception catch (_) {
      yield state.copyWith(pageStatus: PageStatus.failure);
    }
  }
}
