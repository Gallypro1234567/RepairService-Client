import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repairservice/modules/post_find_worker/models/description.dart';
import 'package:repairservice/modules/post_find_worker/models/title.dart';

part 'postfindworker_event.dart';
part 'postfindworker_state.dart';

class PostFindWorkerBloc 
    extends Bloc<PostFindWorkerEvent, PostFindWorkerState> {
  PostFindWorkerBloc() : super(PostFindWorkerState());

  @override
  Stream<PostFindWorkerState> mapEventToState(
    PostFindWorkerEvent event,
  ) async* {
    if (event is PostFindWorkerInitial) {
      yield state.copyWith();
    }
    // Service
    else if (event is PostFindWorkerServiceChanged) {
      //yield state.copyWith(serviceCategory: event.value);
    }
    // Name
    // City
    else if (event is PostFindWorkerCityChanged) {
      yield _mapPostFindWorkerCityChangeToState(event, state);
    }
    // District
    else if (event is PostFindWorkerDistrictChanged) {
      yield _mapPostFindWorkerDistrictChangeToState(event, state);
    }
    // 
     else if (event is PostFindWorkerTitle) {
      yield _mapPostFindWorkerToState(event, state);
    }
  }

  _mapPostFindWorkerToState(
      PostFindWorkerTitle event, PostFindWorkerState state) {
    final value = Title.dirty(event.value);
    return state.copyWith(
        title: value, status: Formz.validate([value, state.description]));
  }

  _mapPostFindWorkerCityChangeToState(
      PostFindWorkerCityChanged event, PostFindWorkerState state) {}

  _mapPostFindWorkerDistrictChangeToState(
      PostFindWorkerDistrictChanged event, PostFindWorkerState state) {}
}
