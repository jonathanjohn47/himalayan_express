// To parse this JSON data, do
//
//     final publisherModel = publisherModelFromJson(jsonString);

import 'dart:convert';

PublisherModel publisherModelFromJson(String str) => PublisherModel.fromJson(json.decode(str));

String publisherModelToJson(PublisherModel data) => json.encode(data.toJson());

class PublisherModel {
  String name;
  String email;
  String password;
  String profilePicLink;
  String dateCreated;

  PublisherModel({
    required this.name,
    required this.email,
    required this.password,
    required this.profilePicLink,
    required this.dateCreated,
  });

  PublisherModel copyWith({
    String? name,
    String? email,
    String? password,
    String? profilePicLink,
    String? dateCreated,
  }) =>
      PublisherModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        profilePicLink: profilePicLink ?? this.profilePicLink,
        dateCreated: dateCreated ?? this.dateCreated,
      );

  factory PublisherModel.fromJson(Map<String, dynamic> json) => PublisherModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    profilePicLink: json["profile_pic_link"],
    dateCreated: json["date_created"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "profile_pic_link": profilePicLink,
    "date_created": dateCreated,
  };
}
