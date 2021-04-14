import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_enum.dart';

class UserRepository {
  Future<UserDetail> fetchUser({String phone, String password}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      var response = await http.get(
        Uri.http("repairservice.somee.com", "/api/services"),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return UserDetail(
            fullname: json["Name"] as String,
            // phone: json["Phone"] as String,
            // sex: json["Sex"] as int == 1
            //     ? Sex.male
            //     : json["Sex"] as int == 2
            //         ? Sex.female
            //         : Sex.orther,
            // email: json["Email"] as String,
            // address: json["Address"] as String,
          );
        }).first;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
