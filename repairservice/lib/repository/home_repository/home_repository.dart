import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:repairservice/repository/auth_repository/models/login_model.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/preferential_model.dart';

class HomeRepository {
  Future<Login> getRole() async {
    var pref = await SharedPreferences.getInstance();
    var role = pref.getInt("role");
    var isCustomer = pref.getBool("isCustomer");
    return Login(
        isCustomer: isCustomer ? UserType.customer : UserType.worker,
        role: role);
  }

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
              imageUrl: json["ImageUrl"] != null
                  ? json["ImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ImageUrl"])
                          .toString()
                      : null
                  : null);
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> addService(
      {String name, File file, String description}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/services/add");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['Name'] = name;
      request.fields['Description'] = description;
      if (file != null) {
        request.files.add(http.MultipartFile(
            'Image', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split("/").last));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {}
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
              imageUrl: json["ImageUrl"] != null
                  ? json["ImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ImageUrl"])
                          .toString()
                      : null
                  : null);
        }).toList();
      }
      return null;
    } on Exception {
      return null;
    }
  }

  Future<http.Response> addPreferential({
    String title,
    String description,
    String fromdate,
    String todate,
    String percent,
    String serviceCodes,
    File file,
  }) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/services/add");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['Title'] = title;
      request.fields['Description'] = description;
      request.fields['Description'] = fromdate;
      request.fields['Description'] = todate;
      request.fields['Description'] = percent;
      request.fields['Description'] = serviceCodes;

      if (file != null) {
        request.files.add(http.MultipartFile(
            'Image', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split("/").last));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {}
  }
}
