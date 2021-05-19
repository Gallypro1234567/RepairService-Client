import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/user_enum.dart';

class UserRepository {
  Future<UserDetail> fetchUser({String phone, String password}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var isCustomer = pref.getBool("isCustomer");
    var role = pref.getInt("role");
    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/auth/detail"),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        if (body != null)
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
              imageUrl: json["ImageUrl"] != null
                  ? json["ImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ImageUrl"])
                          .toString()
                      : null
                  : null,
              isCustomer: isCustomer ? UserType.customer : UserType.worker,
              role: role,
            );
          }).first;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<WorkerApply> fetchWorkerDetail({String phone, String wOfsCode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {"code": wOfsCode};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/workerofservices/$phone/detail",
            paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        if (body != null)
          return body.map((dynamic json) {
            return WorkerApply(
              fullname: json["Fullname"] as String,
              phone: json["Phone"] as String,
              address: json["Address"] as String,
              sex: json["Sex"] as int == 1
                  ? Sex.male
                  : json["Sex"] as int == 2
                      ? Sex.female
                      : json["Sex"] as int == 3
                          ? Sex.orther
                          : Sex.empty,
              cmnd: json["CMND"] as String,
              email: json["Email"] as String,
              createAt: json["CreateAt"] as String,
              serviceName: json["ServiceName"] as String,
              imageUrl: json["ImageUrl"] != null
                  ? json["ImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ImageUrl"])
                          .toString()
                      : null
                  : null,
            );
          }).first;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserDetail> tryGetUser() async {
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
        if (body != null)
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
              imageUrl: json["ImageUrl"] != null
                  ? json["ImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ImageUrl"])
                          .toString()
                      : null
                  : null,
              isCustomer: json["isCustomer"] as bool
                  ? UserType.customer
                  : UserType.worker,
              role: json["Role"] as int,
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

      if (email != null) {
        request.fields['Email'] = email;
      }

      if (address != null) {
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

// Worker
  Future<http.Response> workerRegisterService(
      {String serviceCode, List<File> files}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var uri = Uri.http(Host.Server_hosting, "/api/workerofservices/register");

      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = "bearer $token";

      request.fields['ServiceCode'] = serviceCode;
      request.fields['isApproval'] = "0";

      if (files != null) {
        for (var file in files) {
          request.files.add(http.MultipartFile(
              'File', file.readAsBytes().asStream(), file.lengthSync(),
              filename: file.path.split("/").last));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<WorkerRegister>> fetchWorkerRegisterByUser() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var phone = pref.getString("phone");
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
        Uri.http(
            Host.Server_hosting, "/api/workerofservices/$phone", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return WorkerRegister(
              code: json["Code"] as String,
              isApproval: json["isApproval"] as int,
              serviceCode: json["ServiceCode"] as String,
              serviceName: json["ServiceName"] as String,
              serviceImageurl: json["ServiceImageUrl"] != null
                  ? json["ServiceImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ServiceImageUrl"])
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

  Future<List<Service>> fetchWorkerOfServiceByCode({String serviceCode}) async {
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
}
