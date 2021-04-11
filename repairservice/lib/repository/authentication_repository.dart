import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    var pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      await logIn(phone: "0938879910", password: "123456");
      
      yield* _controller.stream;
    } else {
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
    }
  }

  Future<void> logIns({
    String phone,
    String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<void> logIn({String phone, String password}) async {
    var jsonencoder =
        json.encode({"Phone": "0938879910", "Password": "123456"});
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(
        Uri.http("repairservice.somee.com", "/api/auth/login"),
        headers: headers,
        body: jsonencoder);
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      var pref = await SharedPreferences.getInstance();
      pref.setString("token", data["token"]);
      pref.setString("phone", "0938879910");
      pref.setString("password", "123456");
      return _controller.add(AuthenticationStatus.authenticated);
    } else {
      return _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  void logOut() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("token", null);
    pref.setString("phone", null);
    pref.setString("password", null);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
