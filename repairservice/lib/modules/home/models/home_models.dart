// To parse this JSON data, do
//
//     final News = NewsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    this.name,
    this.caption,
    this.urlDetail,
    this.image,
  });

  String name;
  String caption;
  String urlDetail;
  String image;

  factory News.fromJson(Map<String, dynamic> json) => News(
        name: json["name"],
        caption: json["caption"],
        urlDetail: json["url-detail"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "caption": caption,
        "url-detail": urlDetail,
        "image": image,
      };
}

List<News> news = List.generate(
  demoNews.length,
  (index) => News(
    name: demoNews[index]['name'],
    image: demoNews[index]['image'],
    urlDetail: demoNews[index]['url-detail'],
    caption: demoNews[index]['caption'],
  ),
);

List demoNews = [
  {
    "name": "Chương trình khuyến mãi "
        "Thợ Trao Lì Xì - Sửa Gì Cũng Rẻ"
        " từ ngày 11/01 đến ngày 31/01/2020",
    "caption": " " "Thợ Trao Lì Xì - Sửa Gì Cũng Rẻ" " ",
    "url-detail": "/news/id/iddetail",
    "image": "assets/images/image_05.jpg"
  },
  {
    "name": "Chương trình khuyến mãi abc  - giá rẻ nhất",
    "caption": "thông tin abc - abc",
    "url-detail": "/news/id/iddetail",
    "image": "assets/images/image_02.jpg"
  },
  {
    "name": "Chương trình khuyến mãi abc  - giá rẻ nhất",
    "caption": "thông tin abc - abc",
    "url-detail": "/news/id/iddetail",
    "image": "assets/images/image_03.jpg"
  },
  {
    "name": "Chương trình khuyến mãi abc  - giá rẻ nhất",
    "caption": "thông tin abc - abc",
    "url-detail": "/news/id/iddetail",
    "image": "assets/images/image_04.jpg",
  },
  {
    "name": "Chương trình khuyến mãi abc  - giá rẻ nhất",
    "caption": "thông tin abc - abc",
    "url-detail": "/news/id/iddetail",
    "image": "assets/images/image_04.jpg"
  },
  {
    "name": "Chương trình khuyến mãi abc  - giá rẻ nhất",
    "caption": "thông tin abc - abc",
    "url-detail": "/news/id/iddetail",
    "image": "assets/images/image_04.jpg"
  },
];
