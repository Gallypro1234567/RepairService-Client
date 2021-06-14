import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:repairservice/repository/hub_repository/notification_model.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(NotificationState());
  final PostRepository _postRepository;
  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is NotificationInitial)
      yield state.copyWith(status: NotificationStatus.none);
    else if (event is NotificationOnSelect)
      yield event.select != -1
          ? event.select != 0
              ? event.select != 1
                  ? state.copyWith(
                      pageActive: event.select,
                      status: NotificationStatus.selectPage,
                      checkApply: 1)
                  : state.copyWith(
                      pageActive: event.select,
                      status: NotificationStatus.selectPage,
                      checkAdmin: 1)
              : state.copyWith(
                  pageActive: event.select,
                  status: NotificationStatus.selectPage,
                  checkperson: 1,
                )
          : state.copyWith(
              pageActive: event.select,
              status: NotificationStatus.selectPage,
              checkall: 1);
    else if (event is NotificationFetched)
      yield* _mapNotificationFetchedToState(event, state);
    else if (event is NotificationRefeshed)
      yield* _mapNotificationRefeshedToState(event, state);
    else if (event is NotificationSubmitted)
      yield* _mapNotificationSubmittedToState(event, state);
  }

  Stream<NotificationState> _mapNotificationFetchedToState(
      NotificationFetched event, NotificationState state) async* {
    yield state.copyWith(status: NotificationStatus.loading);
    try {
      var data = await _postRepository.fetchNotifications(
          length: 20, start: 0, status: -1, type: event.type);

      yield event.type != -1
          ? event.type == 0
              ? state.copyWith(
                  notifiadmin: data,
                  status: NotificationStatus.success,
                  checkAdmin: 1,
                  checkperson: state.checkperson,
                  checkall: state.checkall)
              : event.type != 1
                  ? state.copyWith(
                      notifiApply: data,
                      status: NotificationStatus.success,
                      checkApply: 1,
                      checkAdmin: state.checkperson,
                      checkperson: state.checkperson,
                      checkall: state.checkall)
                  : state.copyWith(
                      notifiperson: data,
                      status: NotificationStatus.success,
                      checkperson: 1,
                      checkAdmin: state.checkAdmin,
                      checkall: state.checkall)
          : state.copyWith(
              notifiAll: data,
              status: NotificationStatus.success,
              checkall: 1,
              checkAdmin: state.checkAdmin,
              checkperson: state.checkperson);
    } on Exception catch (_) {
      yield state.copyWith(status: NotificationStatus.failure);
    }
  }

  Stream<NotificationState> _mapNotificationRefeshedToState(
      NotificationRefeshed event, NotificationState state) async* {
    try {
      var data = await _postRepository.fetchNotifications(
          length: 20, start: 0, status: -1, type: event.type);
      yield state.copyWith(notifiAll: data, status: NotificationStatus.success);
    } on Exception catch (_) {
      yield state.copyWith(status: NotificationStatus.failure);
    }
  }

  Stream<NotificationState> _mapNotificationSubmittedToState(
      NotificationSubmitted event, NotificationState state) async* {
    yield state.copyWith(status: NotificationStatus.loading);
    try {
      var res;
      if (event.type == 0)
        res = await _postRepository.seenNotification(code: event.code);
      else
        res = await _postRepository.deleteNotification(code: event.code);
      if (res.statusCode == 200)
        yield state.copyWith(
          status: NotificationStatus.submittedSuccess,
        );
      else
        yield state.copyWith(status: NotificationStatus.failure);
    } on Exception catch (_) {
      yield state.copyWith(status: NotificationStatus.failure);
    }
  }
}
