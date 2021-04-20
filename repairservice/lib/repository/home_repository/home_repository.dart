import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/preferential_model.dart';

class HomeRepository {
  Future<List<Service>> fetchService({String phone, String password}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": "0",
      "length": "1000",
      "order": "1"
    };
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/services", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return Service(
              code: json["Code"] as String,
              name: json["Name"] as String,
              description: json["Description"] as String,
              createAt: json["CreateAt"] as String,
              imageUrl:
                  Uri.http(Host.Server_hosting, json["ImageUrl"]).toString());
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Preferential>> fetchPreferential(
      {String phone, String password}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    };
    Map<String, String> paramters = {
      "start": "0",
      "length": "1000",
      "order": "1"
    };
    try {
      var response = await http.get(
        Uri.http("repairservice.somee.com", "/api/preferentials", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return Preferential(
            code: json["Code"] as String,
            title: json["Title"] as String,
            description: json["Description"] as String,
            imageUrl:
                Uri.http(Host.Server_hosting, json["ImageUrl"]).toString(),
          );
        }).toList();
      }
      return null;
    } on Exception {
      return null;
    }
  }
}
