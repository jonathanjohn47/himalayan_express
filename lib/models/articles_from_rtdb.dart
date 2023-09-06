// To parse this JSON data, do
//
//     final articlesFromRtdb = articlesFromRtdbFromJson(jsonString);

import 'dart:convert';

Map<String, ArticlesFromRtdb> articlesFromRtdbFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, ArticlesFromRtdb>(k, ArticlesFromRtdb.fromJson(v)));

String articlesFromRtdbToJson(Map<String, ArticlesFromRtdb> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ArticlesFromRtdb {
  List<String> category;
  String content;
  String publisherName;
  String thumbnailImageUrl;
  int timestamp;
  String title;
  String url;

  ArticlesFromRtdb({
    required this.category,
    required this.content,
    required this.publisherName,
    required this.thumbnailImageUrl,
    required this.timestamp,
    required this.title,
    required this.url,
  });

  ArticlesFromRtdb copyWith({
    List<String>? category,
    String? content,
    String? publisherName,
    String? thumbnailImageUrl,
    int? timestamp,
    String? title,
    String? url,
  }) =>
      ArticlesFromRtdb(
        category: category ?? this.category,
        content: content ?? this.content,
        publisherName: publisherName ?? this.publisherName,
        thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
        timestamp: timestamp ?? this.timestamp,
        title: title ?? this.title,
        url: url ?? this.url,
      );

  factory ArticlesFromRtdb.fromJson(Map<String, dynamic> json) => ArticlesFromRtdb(
    category: List<String>.from(json["category"].map((x) => x)),
    content: json["content"],
    publisherName: json["publisher_name"],
    thumbnailImageUrl: json["thumbnail_image_url"],
    timestamp: json["timestamp"],
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x)),
    "content": content,
    "publisher_name": publisherName,
    "thumbnail_image_url": thumbnailImageUrl,
    "timestamp": timestamp,
    "title": title,
    "url": url,
  };
}
