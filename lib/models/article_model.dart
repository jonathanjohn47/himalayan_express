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

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.htmlText,
    required this.date,
    required this.headlineImageUrl,
    this.youtubeLink,
    required this.category,
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
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'htmlText': htmlText,
        'date': DateTime(date.year, date.month, date.day, 0, 0, 0)
            .toIso8601String(),
        'headlineImageUrl': headlineImageUrl,
        'youtubeLink': youtubeLink,
        'category': category.toJson(),
      };
}
