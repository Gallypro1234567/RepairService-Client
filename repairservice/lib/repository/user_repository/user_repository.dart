import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/user_enum.dart';

class UserRepository {
  Future<UserDetail> fetchUser({String phone, String password}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/auth/detail"),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return UserDetail(
            fullname: json["Fullname"] as String,
            phone: json["Phone"] as String,
            sex: json["Sex"] as int == 1
                ? Sex.male
                : json["Sex"] as int == 2
                    ? Sex.female
                    : json["Sex"] as int == 3
                        ? Sex.orther
                        : Sex.empty,
            email: json["Email"] as String,
            address: json["Address"] as String,
            imageUrl: json["ImageUrl"] as String,
          );
        }).first;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> modifyOfUserProfile(
      {String fullname,
      String phone,
      int sex,
      String email,
      String address,
      String oldpassword,
      String newpassword,
      File file}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      Map<String, String> query = {"phone": phone};
      var uri = Uri.http(Host.Server_hosting, "/api/auth/update", query);

      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = "bearer $token";

      request.fields['Fullname'] = fullname == null ? "" : fullname;
      request.fields['Sex'] = sex.toString();

      if(email != null){
        request.fields['Email'] = email ;
      }

      if(address != null){
         request.fields['Address'] = address;
      }
 

      if (file != null) {
        request.files.add(http.MultipartFile(
            'File', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split("/").last));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
