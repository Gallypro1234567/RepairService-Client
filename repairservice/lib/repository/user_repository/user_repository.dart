import 'dart:async';
import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:repairservice/repository/user_repository/models/user_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
import 'package:http/http.dart' as http;

enum UserStatus { unknown, authenticated, unauthenticated }

class UserRepository {
  final _controller = StreamController<UserStatus>();
 

  Future<http.Response> register(RegisterModel model) async {
    var jsonencoder =
        json.encode({"Phone": model.phone, "Password": model.password, "Fullname": model.fullname, "isCustomer": model.isCustomer});
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(
        Uri.http("repairservice.somee.com", "/api/auth/register"),
        headers: headers,
        body: jsonencoder);
    return response;
  }

void logOut() async {
  var pref = await SharedPreferences.getInstance();
    pref.setString("token", null);
    pref.setString("phone", null);
    pref.setString("password", null);
    _controller.add(UserStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
