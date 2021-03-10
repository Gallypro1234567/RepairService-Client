import 'dart:convert';

UserCategory userCategoryFromJson(String str) =>
    UserCategory.fromJson(json.decode(str));

String userCategoryToJson(UserCategory data) => json.encode(data.toJson());

class UserCategory {
  UserCategory({
    this.category,
    this.id,
  });

  String category;
  String id;

  factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
        category: json["category"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
      };
}

List<UserCategory> userCategory = List.generate(
  abc.length,
  (index) => UserCategory(
    category: abc[index]['category'],
    id: abc[index]['id'],
  ),
);

List abc = [
  {"category": "Lịch sử công việc", "id": "1"},
  {"category": "Lịch sử giao dịch", "id": "2"},
  {"category": "Danh mục yêu thích", "id": "3"},
  {"category": "Hồ sơ danh nghiệp", "id": "4"},
  {"category": "Điểm thưởng", "id": "5"},
  {"category": "Mời bạn bè", "id": "6"},
  {"category": "Danh sách chặn", "id": "7"},
  {"category": "Cài đặt ", "id": "8"},
  {"category": "Hỗ trợ ", "id": "9"},
];
