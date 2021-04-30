import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;

class DashboardRepository {
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

  Future<Service> fetchServiceDetail(String code) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};

    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/services/$code"),
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
                      : ""
                  : "");
        }).first;
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
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> updateService(
      {String code, String name, File file, String description}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> paramters = {
      "code": code,
    };
    try {
      var uri =
          Uri.http(Host.Server_hosting, "/api/services/update", paramters);

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
    } on Exception catch (_) {
      return null;
    }
  }

  Future<List<UserDetail>> fetchCustomer(
      {String phone, String password}) async {
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
          return UserDetail(
              fullname: json["Code"] as String,
              phone: json["Name"] as String,
              address: json["Description"] as String,
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

  Future<List<UserDetail>> fetchWorker({String phone, String password}) async {
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
        Uri.http(Host.Server_hosting, "/api/users/workers", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return UserDetail(
              fullname: json["Fullname"] as String,
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
    } on Exception {
      return null;
    }
  }

  Future<List<UserDetail>> fetchCustomers(
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
        Uri.http(Host.Server_hosting, "/api/users/customers", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return UserDetail(
              fullname: json["Fullname"] as String,
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
    } on Exception {
      return null;
    }
  }

  Future<List<WorkerRegister>> fetchWorkerRegister() async {
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
        Uri.http(Host.Server_hosting, "/api/workerofservices", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return WorkerRegister(
            code: json["Code"] as String,
            fullname: json["Fullname"] as String,
            phone: json["Phone"] as String,
            address: json["Address"] as String,
            email: json["Email"] as String,
            createAt: json["CreateAt"] as String,
            isApproval: json["isApproval"] as int,
            cmnd: json["CMND"] as String,
            imageUrlcmnd: json["ImageUrlcmnd"] as String,
            imageUrl: json["ImageUrlcmnd"] != null
                ? json["ImageUrlcmnd"].toString().length > 0
                    ? Uri.http(Host.Server_hosting, json["ImageUrlcmnd"])
                        .toString()
                    : null
                : null,
            serviceCode: json["ServiceCode"] as String,
            serviceName: json["ServiceName"] as String,
          );
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

  Future<http.Response> adminVetification(
      {int isApproval, String workerOfServicesCode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri =
          Uri.http(Host.Server_hosting, "api/workerofservices/vetification");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['isApproval'] = isApproval.toString();
      request.fields['WorkerOfServicesCode'] = workerOfServicesCode;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }
}
