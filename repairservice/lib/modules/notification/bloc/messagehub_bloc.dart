import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:signalr_client/signalr_client.dart';
import '../../../utils/service/server_hosting.dart' as Host;
part 'messagehub_event.dart';
part 'messagehub_state.dart';

class MessagehubBloc extends Bloc<MessagehubEvent, MessagehubState> {
  MessagehubBloc() : super(MessagehubState());

  @override
  Stream<MessagehubState> mapEventToState(
    MessagehubEvent event,
  ) async* {
    if (event is MessagehubInitial)
      yield* _mapMessagehubInitialToState(event, state);
  }

  Stream<MessagehubState> _mapMessagehubInitialToState(
      MessagehubInitial event, MessagehubState state) async* {
    final serverUrl = Host.Server_hosting + "/notificationhub";
    HubConnection hubConnection;
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose((error) => print("Connection Error"));
    hubConnection.on("ABC", (arguments) {});
  }
}
