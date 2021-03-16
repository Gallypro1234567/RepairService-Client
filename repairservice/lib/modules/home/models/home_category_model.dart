// To parse this JSON data, do
//
//     final WorkCategoriesModel = WorkCategoriesModelFromJson(jsonString);

import 'dart:convert';

WorkCategoriesModel workCategoriesModelFromJson(String str) =>
    WorkCategoriesModel.fromJson(json.decode(str));

String workCategoriesModelToJson(WorkCategoriesModel data) =>
    json.encode(data.toJson());

class WorkCategoriesModel {
  WorkCategoriesModel({
    this.name,
  });

  String name;

  factory WorkCategoriesModel.fromJson(Map<String, dynamic> json) =>
      WorkCategoriesModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

List<WorkCategoriesModel> workCategories = List.generate(
  response.length,
  (index) => WorkCategoriesModel(name: response[index]["name"]),
);
List response = [
  {"name": "Thợ sửa nước"},
  {"name": "Thợ sửa điện"},
  {"name": "Thợ sửa điện lạnh"},
  {"name": "Thợ sửa abc"},
];
