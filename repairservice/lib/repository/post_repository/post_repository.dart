import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/post.dart';

class PostRepository {
  Future<List<Post>> fetchPost({String serviceCode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": "0",
      "length": "1000",
      "order": "1",
      "status": "0",
      "servicecode": serviceCode,
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
          List<String> imageUrls = [];
          if (json["ImageUrl"] != null) {
            List<String> list = json["ImageUrl"].split(',');
            for (var item in list) {
              imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
            }
          }
          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: json["Address"] as String,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              position: json["Position"] as String,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              phone: json["Phone"] as String,
              email: json["Email"] as String,
              imageUrl: imageUrls.length > 0 ? imageUrls.first : null,
              customerImageUrl: json["CustomerImageUrl"] != null
                  ? json["CustomerImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["CustomerImageUrl"])
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

  Future<Post> fetchPostByCode({String code}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/posts/detail/$code"),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          List<String> imageUrls = [];
          if (json["ImageUrl"] != null) {
            List<String> list = json["ImageUrl"].split(',');
            for (var item in list) {
              imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
            }
          }

          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: json["Address"] as String,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              position: json["Position"] as String,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              phone: json["Phone"] as String,
              email: json["Email"] as String,
              imageUrls: imageUrls,
              serviceCode: json["ServiceCode"],
              serviceText: json["ServiceText"],
              customerImageUrl: json["CustomerImageUrl"] != null
                  ? json["CustomerImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["CustomerImageUrl"])
                          .toString()
                      : null
                  : null);
        }).first;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Post>> fetchRecentlyPost({int start, int length}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": start.toString(),
      "length": length.toString(),
      "order": "1",
      "status": "0"
    };
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/posts/recently", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;

        return body.map((dynamic json) {
          List<String> imageUrls = [];
          if (json["ImageUrl"] != null) {
            List<String> list = json["ImageUrl"].split(',');
            for (var item in list) {
              imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
            }
          }
          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: json["Address"] as String,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              position: json["Position"] as String,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              phone: json["Phone"] as String,
              email: json["Email"] as String,
              imageUrl:
                  imageUrls.length > 0 ? imageUrls.first.toString() : null,
              customerImageUrl: json["CustomerImageUrl"] != null
                  ? json["CustomerImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["CustomerImageUrl"])
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

  Future<List<Post>> fetchPostByPhone() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var phone = pref.getString("phone");
    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": "0",
      "length": "1000",
      "order": "1",
      "servicecode": "02",
      "status": null,
    };
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/posts/$phone", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          List<String> imageUrls = [];
          if (json["ImageUrl"] != null) {
            List<String> list = json["ImageUrl"].split(',');
            for (var item in list) {
              imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
            }
          }
          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: json["Address"] as String,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              position: json["Position"] as String,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              phone: json["Phone"] as String,
              email: json["Email"] as String,
              imageUrls: imageUrls,
              imageUrl: imageUrls.length == 0 ? null : imageUrls.first);
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> customerAddPost(
      {String title,
      String position,
      String serviceCode,
      String address,
      String finishAt,
      int status,
      List<File> files,
      String description}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/posts/add");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['ServiceCode'] = serviceCode == null ? "" : serviceCode;
      request.fields['Title'] = title == null ? "" : title;
      request.fields['Position'] = position == null ? "" : position;
      request.fields['Address'] = address == null ? "" : address;
      request.fields['FinishAt'] =
          DateTime.now().add(const Duration(days: 3)).toString();
      request.fields['status'] = status.toString();
      request.fields['Description'] = description == null ? "" : description;

      if (files.length > 0) {
        for (var file in files) {
          request.files.add(http.MultipartFile(
              'Image', file.readAsBytes().asStream(), file.lengthSync(),
              filename: file.path.split("/").last));
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> customerUpdatePost(
      {String title,
      String code,
      String position,
      String serviceCode,
      String address,
      String finishAt,
      int status,
      List<dynamic> files,
      String description}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> paramters = {"code": code};
    try {
      var uri = Uri.http(
          Host.Server_hosting, "/api/posts/updatebycustomer", paramters);

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['ServiceCode'] = serviceCode == null ? "" : serviceCode;
      request.fields['Title'] = title == null ? "" : title;
      request.fields['Position'] = position == null ? "" : position;
      request.fields['Address'] = address == null ? "" : address;
      request.fields['FinishAt'] =
          DateTime.now().add(const Duration(days: 3)).toString();
      request.fields['status'] = status.toString();
      request.fields['Description'] = description == null ? "" : description;

      if (files.length > 0) {
        for (var file in files) {
          if (file is File)
            request.files.add(http.MultipartFile(
                'Image', file.readAsBytes().asStream(), file.lengthSync(),
                filename: file.path.split("/").last));
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> workerApplyPost({
    String postCode,
  }) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> paramters = {"code": postCode};
    try {
      var uri =
          Uri.http(Host.Server_hosting, "/api/posts/updatebyworker", paramters);

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> deletePostByCustomer({
    String postCode,
  }) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> paramters = {"code": postCode};
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/posts/delete", paramters);

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }
}
