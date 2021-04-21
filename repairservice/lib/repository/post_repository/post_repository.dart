import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/post.dart';

class PostRepository {
  Future<List<Post>> fetchPost() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": "0",
      "length": "1000",
      "order": "1",
      "servicecode": "02",
    };
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/posts", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: json["Address"] as String,
              createAt: DateTime.parse(json["CreateAt"]),
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              position: json["Position"] as String,
              status: json["status"] as int,
              phone: json["Phone"] as String,
              email: json["Email"] as String,
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

  Future<http.Response> addPost(
      {String title,
      String position,
      String address,
      String finishAt,
      int status,
      File file,
      String description}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/posts/add");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['Title'] = title == null ? "" : title;
      request.fields['Position'] = position == null ? "" : position;
      request.fields['Address'] = address == null ? "" : address;
      request.fields['FinishAt'] =
          DateTime.now().add(const Duration(days: 3)).toString();
      request.fields['status'] = status.toString();
      request.fields['Description'] = description == null ? "" : description;

      if (file != null) {
        request.files.add(http.MultipartFile(
            'Image', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split("/").last));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }
}
