import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'postfindworker_event.dart';
part 'postfindworker_state.dart';

class PostfindworkerBloc extends Bloc<PostfindworkerEvent, PostfindworkerState> {
  PostfindworkerBloc() : super(PostfindworkerInitial());

  @override
  Stream<PostfindworkerState> mapEventToState(
    PostfindworkerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
