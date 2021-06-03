import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:repairservice/repository/hub_repository/notification_model.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/service/server_hosting.dart' as Host;
import 'models/city_model.dart';
import 'models/post.dart';
import 'models/post_apply.dart';
import 'models/post_detail_pefect.dart';

class PostRepository {
  Future<List<City>> fetchCities() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      var response = await http.get(
          Uri.http(Host.Server_hosting, "/api/location/provinces"),
          headers: headers);
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return City(
            id: int.parse(json["Id"]),
            title: json["Name"] as String,
          );
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<District>> fetchDistrictbyCityId({String provinceId}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      Map<String, String> paramters = {
        "cityid": provinceId,
      };
      var response = await http.get(
          Uri.http(Host.Server_hosting, "/api/location/districts", paramters),
          headers: headers);
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;

        return body.map((dynamic json) {
          return District(
            id: int.parse(json["Id"]),
            title: json["Name"] as String,
          );
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Ward>> fetchWardbyDisctrictId(
      {String provinceId, String districtId}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    try {
      Map<String, String> paramters = {
        "cityid": provinceId,
        "districtid": districtId
      };
      var response = await http.get(
          Uri.http(Host.Server_hosting, "/api/location/wards", paramters),
          headers: headers);
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;

        return body.map((dynamic json) {
          return Ward(
            id: int.parse(json["Id"]),
            title: json["Name"] as String,
          );
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Post>> fetchPost(
      {String serviceCode,
      String cityId,
      String districtId,
      int start = 0,
      int lenght = 10,
      int status = -2,
      int approval = -2}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": start.toString(),
      "length": lenght.toString(),
      "order": "1",
      "status": status.toString(),
      "servicecode": serviceCode,
      "cityid": cityId,
      "districtId": districtId,
      "approval": approval.toString()
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
          String addressShort;
          if (json["ImageUrl"] != null) {
            if (json["ImageUrl"].toString().isNotEmpty) {
              List<String> list = json["ImageUrl"].split(',');
              for (var item in list) {
                imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
              }
            }
          }
          if (json["Address"] != null) {
            if (json["Address"].toString().isNotEmpty) {
              List<String> list = json["Address"].split(',');
              if (list.length == 3) {
                addressShort = list[1].toString() + "," + list[2];
              } else
                addressShort = json["Address"].toString();
            }
          }
          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: addressShort,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              cityId: json["CityId"] as int,
              districtId: json["DistrictId"] as int,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              approval: json["approval"] as int,
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
            if (json["ImageUrl"].toString().isNotEmpty) {
              List<String> list = json["ImageUrl"].split(',');
              for (var item in list) {
                imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
              }
            }
          }

          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: json["Address"] as String,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              cityId: json["CityId"] as int,
              districtId: json["DistrictId"] as int,
              wardId: json["WardId"] as int,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              approval: json["approval"] as int,
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

  Future<List<WorkerApply>> fetchPostApplyByCode({String postCode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {"postCode": postCode};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/applies/getbycustomer", paramters),
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

          return WorkerApply(
            fullname: json["Fullname"] as String,
            phone: json["Phone"] as String,
            address: json["Address"] as String,
            status: json["ApplyStatus"] as int,
            cmnd: json["CMND"] as String,
            serviceName: json["ServiceName"] as String,
            createAt: json["CreateAt"] as String,
            postStatus: json["PostStatus"] as int,
            pointFeedback: json["AVGFeedbackPoint"] as double,
            imageUrl: json["ImageUrl"] != null
                ? json["ImageUrl"].toString().length > 0
                    ? Uri.http(Host.Server_hosting, json["ImageUrl"]).toString()
                    : null
                : null,
            workerOfServiceCode: json["WorkerOfServiceCode"] as String,
          );
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<WorkerRate> fetchFeedbackReviewByWofSCode({String wofscode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {"wofscode": wofscode};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/feedbacks/getdetail", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return WorkerRate(
              fullname: json["Fullname"] as String,
              phone: json["Phone"] as String,
              services: json["WorkerOfServiceName"] as String,
              avgPoint: json["AVGPoint"] == null
                  ? 0.0
                  : double.parse(json["AVGPoint"].toString()),
              feedbackAmount: int.parse(json["FeedbackAmount"].toString()),
              postAmount: int.parse(json["PostAmount"].toString()),
              finishAmount: int.parse(json["PostFinishAmount"].toString()),
              cancelAmount: int.parse(json["PostCancelAmount"].toString()),
              fivePercent: double.parse(json["FivePercent"].toString()),
              fourPercent: double.parse(json["FourPercent"].toString()),
              threePercent: double.parse(json["ThreePercent"].toString()),
              twoPercent: double.parse(json["TwoPercent"].toString()),
              onePercent: double.parse(json["OnePercent"].toString()),
              imageUrl: json["ImageUrl"] != null
                  ? json["ImageUrl"].toString().length > 0
                      ? Uri.http(Host.Server_hosting, json["ImageUrl"])
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

  Future<List<FeedBack>> fetchFeedbackByWofSCode(
      {String wofscode, int start, int length}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "wofscode": wofscode,
      "start": start.toString(),
      "length": length.toString()
    };
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/feedbacks/getby", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return FeedBack(
              username: json["Fullname"] as String,
              description: json["Description"] as String,
              createAt: json["CreateAt"] as String,
              rate: double.parse(json["PointRating"].toString()),
              userImageUrl: json["ImageUrl"] != null
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

  Future<http.Response> customerPostReviewRating(
      {String workerofservicecode,
      String postcode,
      String description,
      double pointrating}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/feedbacks/add");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['workerofservicecode'] = workerofservicecode;
      request.fields['postcode'] = postcode;
      request.fields['description'] = description == null ? "" : description;
      request.fields['pointrating'] =
          pointrating == null ? "" : pointrating.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<int> checkApplybyWorker({String postCode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {"postCode": postCode};
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/applies/checkby", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return json["Status"] == null
              ? 0
              : int.parse(json["Status"].toString());
        }).first;
      }
      return -1;
    } on Exception catch (e) {
      print(e);
      return -1;
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
          String addressShort = "";
          if (json["ImageUrl"] != null) {
            if (json["ImageUrl"].toString().isNotEmpty) {
              List<String> list = json["ImageUrl"].split(',');
              for (var item in list) {
                imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
              }
            }
          }
          if (json["Address"] != null) {
            if (json["Address"].toString().isNotEmpty) {
              List<String> list = json["Address"].split(',');
              if (list.length == 3) {
                addressShort = list[1].toString() + "," + list[2];
              } else
                addressShort = json["Address"].toString();
            }
          }
          return Post(
              code: json["Code"] as String,
              title: json["Title"] as String,
              address: addressShort,
              createAt: json["CreateAt"] as String,
              finishAt: DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              cityId: json["CityId"] as int,
              districtId: json["DistrictId"] as int,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              approval: json["approval"] as int,
              phone: json["Phone"] as String,
              email: json["Email"] as String,
              serviceText: json["ServiceName"] as String,
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

  Future<PostPerfect> fetchPostPerfect({String postCode}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {"postcode": postCode};
    try {
      var response = await http.get(
        Uri.http(
            Host.Server_hosting, "/api/posts/getdetailfinishby", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;

        return body.map((dynamic json) {
          return PostPerfect(
            customerfullname: json["CustomerFullname"] as String,
            customerAddress: json["CustomerAddress"] as String,
            customerphone: json["CustomerPhone"] as String,
            workerfullname: json["WorkerFullname"] as String,
            workerAddress: json["WorkerAddress"] as String,
            workerphone: json["WorkerPhone"] as String,
            workerCMND: json["WorkerCMND"] as String,
            wofsCode: json["WorkerOfServiceCode"] as String,
            postCode: json["PostCode"] as String,
            postTitle: json["PostTitle"] as String,
            postStatus: int.parse(json["PostStatus"].toString()),
            feedbackStatus: int.parse(json["FeedbackStatus"].toString()),
            serviceCode: json["ServiceCode"] as String,
            serviceName: json["ServiceName"] as String,
            applyStatus: int.parse(json["ApplyStatus"].toString()),
          );
        }).first;
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
    var isCustomer = pref.getBool("isCustomer");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "start": "0",
      "length": "1000",
      "order": "1",
      "status": null,
    };

    try {
      http.Response response;

      if (!isCustomer) {
        var posts = await fetchPostByWorkerPhone();
        return posts;
      } else
        response = await http.get(
          Uri.http(Host.Server_hosting, "/api/posts/$phone", paramters),
          headers: headers,
        );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          List<String> imageUrls = [];
          String addressShort;
          if (json["ImageUrl"] != null) {
            if (json["ImageUrl"].toString().isNotEmpty) {
              List<String> list = json["ImageUrl"].split(',');
              for (var item in list) {
                imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
              }
            }
          }
          if (json["Address"] != null) {
            if (json["Address"].toString().isNotEmpty) {
              List<String> list = json["Address"].split(',');
              if (list.length == 3) {
                addressShort = list[1].toString() + "," + list[2];
              } else
                addressShort = json["Address"].toString();
            }
          }
          return Post(
              code: json["Code"] as String,
              wofsCode: json["WorkerOfServiceCode"] as String,
              serviceCode: json["ServiceCode"] as String,
              serviceText: json["ServiceName"] as String,
              title: json["Title"] as String,
              address: addressShort,
              createAt: json["CreateAt"] as String,
              finishAt: json["FinishAt"] == null
                  ? null
                  : DateTime.parse(json["FinishAt"]),
              fullname: json["Fullname"] as String,
              cityId: json["CityId"] as int,
              districtId: json["DistrictId"] as int,
              desciption: json["Description"] as String,
              status: json["status"] as int,
              approval: json["approval"] as int,
              applyAmount: json["ApplyAmount"] as int,
              feedbackAmount: json["FeedbackAmount"] as int,
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

  Future<List<Post>> fetchPostByWorkerPhone() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var phone = pref.getString("phone");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters1 = {
      "phone": phone,
    };
    try {
      http.Response response;

      response = await http.get(
        Uri.http(Host.Server_hosting, "/api/applies/getbyworker", paramters1),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          List<String> imageUrls = [];
          String addressShort;
          if (json["ImageUrl"] != null) {
            if (json["ImageUrl"].toString().isNotEmpty) {
              List<String> list = json["ImageUrl"].split(',');
              for (var item in list) {
                imageUrls..add(Uri.http(Host.Server_hosting, item).toString());
              }
            }
          }
          if (json["Address"] != null) {
            if (json["Address"].toString().isNotEmpty) {
              List<String> list = json["Address"].split(',');
              if (list.length == 3) {
                addressShort = list[1].toString() + "," + list[2];
              } else
                addressShort = json["Address"].toString();
            }
          }
          return Post(
              fullname: json["CustomerFullname"] as String,
              phone: json["CustomerPhone"] as String,
              code: json["PostCode"] as String,
              title: json["Title"] as String,
              createAt: json["CreateAt"] as String,
              wofsCode: json["WorkerOfServiceCode"] as String,
              status: int.parse(json["PostStatus"].toString()),
              feedbackAmount: json["FeedbackAmount"] as int,
              applystatus: int.parse(json["ApplyStatus"].toString()),
              address: addressShort,
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
      String cityId,
      String districtId,
      String wardId,
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
      request.fields['CityId'] = cityId == null ? "" : cityId;
      request.fields['DistrictId'] = districtId == null ? "" : districtId;
      request.fields['WardId'] = wardId == null ? "" : wardId;
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
      // var length = request.contentLength;
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
      String cityId,
      String districtId,
      String wardId,
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
      request.fields['CityId'] = cityId == null ? "" : cityId;
      request.fields['DistrictId'] = districtId == null ? "" : districtId;
      request.fields['WardId'] = wardId == null ? "" : wardId;
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

  Future<http.Response> adminApprovalPost({String code, int approved}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/posts/approvalbyadmin");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['approval'] = approved.toString();
      request.fields['code'] = code;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> customerAcceptPostApply(
      {String workerofservicecode,
      String postcode,
      int status,
      int poststatus}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/applies/updatebycustomer");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['workerofservice'] = workerofservicecode;
      request.fields['postcode'] = postcode == null ? "" : postcode;
      request.fields['status'] = status.toString();
      request.fields['poststatus'] = poststatus.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> workerPostApplyFinish(
      {String workerofservicecode,
      String postcode,
      int applystatus,
      int poststatus}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri =
          Uri.http(Host.Server_hosting, "/api/applies/checkinbyworker/finish");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['workerofservice'] = workerofservicecode;
      request.fields['postcode'] = postcode == null ? "" : postcode;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> workerPostApplyFinishCancel(
      {String workerofservicecode,
      String postcode,
      int applystatus,
      int poststatus}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri =
          Uri.http(Host.Server_hosting, "/api/applies/checkinbyworker/cancel");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['workerofservice'] = workerofservicecode;
      request.fields['postcode'] = postcode == null ? "" : postcode;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> customerCancelPostApply(
      {String workerofservicecode,
      String postcode,
      int status,
      int poststatus}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/applies/deletebycustomer");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['workerofservice'] = workerofservicecode;
      request.fields['postcode'] = postcode == null ? "" : postcode;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> workerApplyPost(
      {String postCode, String workerphone, int status}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/applies/addbycustomer");
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['postCode'] = postCode;
      request.fields['status'] = status.toString();
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

  Future<http.Response> deletePostApplyByWorker({
    String postCode,
  }) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(Host.Server_hosting, "/api/applies/deletebyworker");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['postCode'] = postCode;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> sendNotification(
      {String tilte, String content, String receiveBy}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var uri = Uri.http(
          Host.Server_hosting, "/api/notifications/SendToSpecificUser");
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      request.fields['Title'] = tilte;
      request.fields['Content'] = content.toString();
      request.fields['ReceiveBy'] = receiveBy.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> deleteNotification({String code}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> paramters = {
      "code": code.toString(),
    };
    try {
      var uri =
          Uri.http(Host.Server_hosting, "/api/notifications/delete", paramters);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<http.Response> seenNotification({
    String code,
  }) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Map<String, String> paramters = {
      "code": code.toString(),
    };
    try {
      var uri =
          Uri.http(Host.Server_hosting, "/api/notifications/update", paramters);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = "bearer $token";
      var streamedResponse = await request.send().timeout(Duration(seconds: 10));
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on TimeoutException catch (_) {
      return null;
    } on SocketException catch (_) {
      // Other exception
    }
  }

  Future<List<NotificationModel>> fetchNotifications(
      {int status, int start, int length, int type}) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var phone = pref.getString("phone");

    Map<String, String> headers = {"Authorization": "bearer $token"};
    Map<String, String> paramters = {
      "phone": phone.toString(),
      "status": status.toString(),
      "start": start.toString(),
      "length": length.toString(),
      "type": type.toString()
    };
    try {
      var response = await http.get(
        Uri.http(Host.Server_hosting, "/api/notifications", paramters),
        headers: headers,
      );
      var jsons = json.decode(response.body);
      if (response.statusCode == 200) {
        var body = jsons['data'] as List;
        return body.map((dynamic json) {
          return NotificationModel(
            code: json["Code"] as String,
            title: json["Title"] as String,
            content: json["Content"] as String,
            sendBy: json["SendBy"] as String,
            isReaded: json["isReaded"] as int,
            createAt: json["CreateAt"] as String,
            type: json["type"] as int,
          );
        }).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
