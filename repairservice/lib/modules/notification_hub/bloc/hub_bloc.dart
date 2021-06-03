import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hub_event.dart';
part 'hub_state.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  HubBloc() : super(HubInitial());

  @override
  Stream<HubState> mapEventToState(
    HubEvent event,
  ) async* {
    
  }
  // Stream<HubState> _mapMessagehubInitialToState(
  //     MessagehubInitial event, HubState state) async* {
  //   final serverUrl = Host.Server_hosting + "/notificationhub?UserId";
  //   HubConnection hubConnection;
  //   hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  //   hubConnection.onclose((error) => print("Connection Error"));
  //   hubConnection.on("ABC", (arguments) {});
  // }
}
