// To parse this JSON data, do
//
//     final articlesFromRtdb = articlesFromRtdbFromJson(jsonString);

import 'dart:convert';

List<ArticlesFromRtdb> articlesFromRtdbFromJson(String str) => List<ArticlesFromRtdb>.from(json.decode(str).map((x) => ArticlesFromRtdb.fromJson(x)));

String articlesFromRtdbToJson(List<ArticlesFromRtdb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticlesFromRtdb {
  String title;
  String content;
  String url;
  int timestamp;
  List<Category> category;
  String publisherName;
  String thumbnailImageUrl;

  ArticlesFromRtdb({
    required this.title,
    required this.content,
    required this.url,
    required this.timestamp,
    required this.category,
    required this.publisherName,
    required this.thumbnailImageUrl,
  });

  ArticlesFromRtdb copyWith({
    String? title,
    String? content,
    String? url,
    int? timestamp,
    List<Category>? category,
    String? publisherName,
    String? thumbnailImageUrl,
  }) =>
      ArticlesFromRtdb(
        title: title ?? this.title,
        content: content ?? this.content,
        url: url ?? this.url,
        timestamp: timestamp ?? this.timestamp,
        category: category ?? this.category,
        publisherName: publisherName ?? this.publisherName,
        thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
      );

  factory ArticlesFromRtdb.fromJson(Map<String, dynamic> json) => ArticlesFromRtdb(
    title: json["title"],
    content: json["content"],
    url: json["url"],
    timestamp: json["timestamp"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    publisherName: json["publisher_name"],
    thumbnailImageUrl: json["thumbnail_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "url": url,
    "timestamp": timestamp,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "publisher_name": publisherName,
    "thumbnail_image_url": thumbnailImageUrl,
  };
}

class Category {
  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  String taxonomy;
  String description;
  int parent;
  int count;
  String filter;
  int catId;
  int categoryCount;
  String categoryDescription;
  String catName;
  String categoryNicename;
  int categoryParent;

  Category({
    required this.termId,
    required this.name,
    required this.slug,
    required this.termGroup,
    required this.termTaxonomyId,
    required this.taxonomy,
    required this.description,
    required this.parent,
    required this.count,
    required this.filter,
    required this.catId,
    required this.categoryCount,
    required this.categoryDescription,
    required this.catName,
    required this.categoryNicename,
    required this.categoryParent,
  });

  Category copyWith({
    int? termId,
    String? name,
    String? slug,
    int? termGroup,
    int? termTaxonomyId,
    String? taxonomy,
    String? description,
    int? parent,
    int? count,
    String? filter,
    int? catId,
    int? categoryCount,
    String? categoryDescription,
    String? catName,
    String? categoryNicename,
    int? categoryParent,
  }) =>
      Category(
        termId: termId ?? this.termId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        termGroup: termGroup ?? this.termGroup,
        termTaxonomyId: termTaxonomyId ?? this.termTaxonomyId,
        taxonomy: taxonomy ?? this.taxonomy,
        description: description ?? this.description,
        parent: parent ?? this.parent,
        count: count ?? this.count,
        filter: filter ?? this.filter,
        catId: catId ?? this.catId,
        categoryCount: categoryCount ?? this.categoryCount,
        categoryDescription: categoryDescription ?? this.categoryDescription,
        catName: catName ?? this.catName,
        categoryNicename: categoryNicename ?? this.categoryNicename,
        categoryParent: categoryParent ?? this.categoryParent,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    termId: json["term_id"],
    name: json["name"],
    slug: json["slug"],
    termGroup: json["term_group"],
    termTaxonomyId: json["term_taxonomy_id"],
    taxonomy: json["taxonomy"],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    filter: json["filter"],
    catId: json["cat_ID"],
    categoryCount: json["category_count"],
    categoryDescription: json["category_description"],
    catName: json["cat_name"],
    categoryNicename: json["category_nicename"],
    categoryParent: json["category_parent"],
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
    "slug": slug,
    "term_group": termGroup,
    "term_taxonomy_id": termTaxonomyId,
    "taxonomy": taxonomy,
    "description": description,
    "parent": parent,
    "count": count,
    "filter": filter,
    "cat_ID": catId,
    "category_count": categoryCount,
    "category_description": categoryDescription,
    "cat_name": catName,
    "category_nicename": categoryNicename,
    "category_parent": categoryParent,
  };
}
