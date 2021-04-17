import 'dart:convert';
import 'dart:io';

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
            phone: json["Name"] as String,
            email: json["Name"] as String,
            address: json["Name"] as String,
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

  Future<http.StreamedResponse> modifyOfUserProfile(
      {String fullname,
      String sex,
      String email,
      String address,
      String oldpassword,
      String newpassword,
      File file}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    var jsonencoder = json.encode({
      "Fullname": fullname,
      "Sex": sex,
      "Email": email,
      "Address": address,
      "OldPassword": oldpassword,
      "NewPassword": newpassword
    });
    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      // var request = await  http.post(
      //   Uri.http("repairservice.somee.com", "/api/user/update"),
      //   headers: headers,
      //   body: jsonencoder,
      // );
      // if (request.statusCode == 200) {}
      // return request;
      var uri = Uri.http("repairservice.somee.com", "/api/user/update");

      var request = http.MultipartRequest('POST', uri);
      request.fields['Fullname'] = fullname;
      request.fields['Sex'] = sex;
      request.fields['Email'] = email;
      request.fields['Address'] = address;
      request.fields['OldPassword'] = oldpassword;
      request.fields['NewPassword'] = newpassword;

      request.files.add(http.MultipartFile(
          'File', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split("/").last));
      var res = await request.send();

      return res;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
