import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:signalr_client/signalr_client.dart';
import '../../utils/service/server_hosting.dart' as Host;

class HubRepository {
  Future<String> fetchCities() async {
    try {
      final serverUrl = Host.Server_hosting + "/api/city";
      HubConnection hubConnection;
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
