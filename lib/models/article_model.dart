import 'package:himalayan_express/models/publisher_model.dart';

import 'category_model.dart';

class ArticleModel {
  String id;
  String title;
  String description;
  String htmlText;
  DateTime date;
  String headlineImageUrl;
  String? youtubeLink;
  ArticleCategoryModel category;
  PublisherModel publisher;

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.htmlText,
    required this.date,
    required this.headlineImageUrl,
    this.youtubeLink,
    required this.category,
    required this.publisher,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      htmlText: json['htmlText'],
      date: DateTime.parse(json['date']),
      headlineImageUrl: json['headlineImageUrl'],
      youtubeLink: json['youtubeLink'],
      category: ArticleCategoryModel.fromJson(json['category']),
      publisher: PublisherModel.fromJson(json['publisher']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'htmlText': htmlText,
        'date': date.toIso8601String(),
        'headlineImageUrl': headlineImageUrl,
        'youtubeLink': youtubeLink,
        'category': category.toJson(),
        'publisher': publisher.toJson(),
      };
}
