import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:repairservice/repository/user_repository/models/user_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    if (token != null) {
      bool hasExpired = JwtDecoder.isExpired(token);
      if (!hasExpired) {
        var phone = pref.getString("phone");
        var pasword = pref.getString("password");
        await logIn(phone: phone, password: pasword);
        yield* _controller.stream;
      } else {
        yield AuthenticationStatus.unauthenticated;
        yield* _controller.stream;
      }
    } else {
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
    }
  }

  Future<http.Response> logIn({String phone, String password}) async {
    var jsonencoder = json.encode({"Phone": phone, "Password": password});
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(
        Uri.http("repairservice.somee.com", "/api/auth/login"),
        headers: headers,
        body: jsonencoder);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var pref = await SharedPreferences.getInstance();
      pref.clear();
      pref.setString("token", data["token"]);
      pref.setString("phone", phone);
      pref.setString("password", password);
      _controller.add(AuthenticationStatus.authenticated);
    }
    return response;
  }

  Future<http.Response> register(RegisterModel model) async {
    var jsonencoder = json.encode({
      "Phone": model.phone,
      "Password": model.password,
      "Fullname": model.fullname,
      "isCustomer": model.isCustomer
    });
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(
        Uri.http("repairservice.somee.com", "/api/auth/register"),
        headers: headers,
        body: jsonencoder);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var pref = await SharedPreferences.getInstance();
      pref.clear();
      pref.setString("token", data["token"]);
      pref.setString("phone", model.phone);
      pref.setString("fullname", model.fullname);
      pref.setString("password", model.password);
      _controller.add(AuthenticationStatus.authenticated);
    }
    return response;
  } 

  Future<void> logOut() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
