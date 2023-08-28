// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String firstName;
  String lastName;
  String email;
  DateTime accountCreatedOn;
  bool isBlocked;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accountCreatedOn,
    required this.isBlocked,
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? accountCreatedOn,
    bool? isBlocked,
  }) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        accountCreatedOn: accountCreatedOn ?? this.accountCreatedOn,
        isBlocked: isBlocked ?? this.isBlocked,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        accountCreatedOn: DateTime.parse(json["account_created_on"]),
        isBlocked: json["is_blocked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "account_created_on": accountCreatedOn.toIso8601String(),
        "is_blocked": isBlocked,
      };
}
