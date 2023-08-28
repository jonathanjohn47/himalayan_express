// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  String id;
  String name;
  double price;
  int durationInMonths;

  CourseModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationInMonths,
  });

  CourseModel copyWith({
    String? id,
    String? name,
    double? price,
    int? durationInMonths,
  }) =>
      CourseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        durationInMonths: durationInMonths ?? this.durationInMonths,
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json["id"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    durationInMonths: json["duration_in_months"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "duration_in_months": durationInMonths,
  };
}
