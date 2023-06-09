class ArticleCategoryModel {
  final String id;
  final int categoryNumber;
  final String name;

  ArticleCategoryModel({
    required this.id,
    required this.categoryNumber,
    required this.name,
  });

  factory ArticleCategoryModel.fromJson(Map<String, dynamic> json) {
    return ArticleCategoryModel(
      id: json['id'],
      categoryNumber: json['categoryNumber'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryNumber': categoryNumber,
    'name': name,
  };

  //copy with
  ArticleCategoryModel copyWith({
    String? id,
    int? categoryNumber,
    String? name,
  }) {
    return ArticleCategoryModel(
      id: id ?? this.id,
      categoryNumber: categoryNumber ?? this.categoryNumber,
      name: name ?? this.name,
    );
  }
}
