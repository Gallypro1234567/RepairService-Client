import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/preferential_model.dart';

class HomeRepository {
  Future<List<Service>> fetchService({String phone, String password}) async {
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
          return Service(
            code: json["Code"] as String,
            name: json["Name"] as String,
            description:  json["Description"] as String,
            createAt: json["CreateAt"] as String,
            imageUrl: json["ImageUrl"] as String

          );
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Preferential>> fetchPreferential({String phone, String password}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    };
    try {
      var response = await http.get(
        Uri.http("repairservice.somee.com", "/api/preferentials"),
        headers: headers,
      );
       var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return Preferential(
            code: json["Code"] as String,
            title : json["Title"] as String,
            description: json["Description"] as String,
            imageUrl: "assets/images/image_05.jpg",
          );
        }).toList();
      }
      return null;
    } on Exception {
      return null;
    }
  }
}