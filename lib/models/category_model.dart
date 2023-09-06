// To parse this JSON data, do
//
//     final articleCategoryModel = articleCategoryModelFromJson(jsonString);

import 'dart:convert';

ArticleCategoryModel articleCategoryModelFromJson(String str) => ArticleCategoryModel.fromJson(json.decode(str));

String articleCategoryModelToJson(ArticleCategoryModel data) => json.encode(data.toJson());

class ArticleCategoryModel {
  String id;
  int categoryNumber;
  String name;
  bool requiresRegistration;

  ArticleCategoryModel({
    required this.id,
    required this.categoryNumber,
    required this.name,
    required this.requiresRegistration,
  });

  ArticleCategoryModel copyWith({
    String? id,
    int? categoryNumber,
    String? name,
    bool? requiresRegistration,
  }) =>
      ArticleCategoryModel(
        id: id ?? this.id,
        categoryNumber: categoryNumber ?? this.categoryNumber,
        name: name ?? this.name,
        requiresRegistration: requiresRegistration ?? this.requiresRegistration,
      );

  factory ArticleCategoryModel.fromJson(Map<String, dynamic> json) => ArticleCategoryModel(
    id: json["id"],
    categoryNumber: json["categoryNumber"],
    name: json["name"],
    requiresRegistration: json["requires_registration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryNumber": categoryNumber,
    "name": name,
    "requires_registration": requiresRegistration,
  };

  factory ArticleCategoryModel.empty() => ArticleCategoryModel(
    id: '',
    categoryNumber: 0,
    name: '',
    requiresRegistration: false,
  );
}
