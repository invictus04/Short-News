// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  String category;
  List<Datum> data;
  bool success;

  News({
    required this.category,
    required this.data,
    required this.success,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    category: json["category"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
  };
}

class Datum {
  String? author;
  String? content;
  Date date;
  String id;
  String? imageUrl;
  String? readMoreUrl;
  String time;
  String? title;
  String url;

  Datum({
     this.author,
     this.content,
    required this.date,
    required this.id,
    this.imageUrl,
    this.readMoreUrl,
    required this.time,
    this.title,
    required this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    author: json["author"],
    content: json["content"],
    date: dateValues.map[json["date"]] ?? Date.WEDNESDAY_26_MARCH_2025,
    id: json["id"],
    imageUrl: json["imageUrl"],
    readMoreUrl: json["readMoreUrl"],
    time: json["time"],
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "content": content,
    "date": dateValues.reverse[date],
    "id": id,
    "imageUrl": imageUrl,
    "readMoreUrl": readMoreUrl,
    "time": time,
    "title": title,
    "url": url,
  };
}

enum Date {
  WEDNESDAY_26_MARCH_2025
}

final dateValues = EnumValues({
  "Wednesday, 26 March, 2025": Date.WEDNESDAY_26_MARCH_2025
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
