import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'servicebloc_event.dart';
part 'servicebloc_state.dart';

class ServiceblocBloc extends Bloc<ServiceblocEvent, ServiceblocState> {
  ServiceblocBloc() : super(ServiceblocInitial());

  @override
  Stream<ServiceblocState> mapEventToState(
    ServiceblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
