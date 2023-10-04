// To parse this JSON data, do
//
//     final articleCategoryModel = articleCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ArticleCategoryModel> articleCategoryModelFromJson(String str) => List<ArticleCategoryModel>.from(json.decode(str).map((x) => ArticleCategoryModel.fromJson(x)));

String articleCategoryModelToJson(List<ArticleCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleCategoryModel {
  int id;
  String name;
  String description;
  String slug;
  int count;

  ArticleCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.count,
  });

  ArticleCategoryModel copyWith({
    int? id,
    String? name,
    String? description,
    String? slug,
    int? count,
  }) =>
      ArticleCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        slug: slug ?? this.slug,
        count: count ?? this.count,
      );

  factory ArticleCategoryModel.fromJson(Map<String, dynamic> json) => ArticleCategoryModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    slug: json["slug"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "slug": slug,
    "count": count,
  };
}
