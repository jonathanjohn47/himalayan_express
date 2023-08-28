// To parse this JSON data, do
//
//     final ePaperModel = ePaperModelFromJson(jsonString);

import 'dart:convert';

EPaperModel ePaperModelFromJson(String str) =>
    EPaperModel.fromJson(json.decode(str));

String ePaperModelToJson(EPaperModel data) => json.encode(data.toJson());

class EPaperModel {
  String date;
  List<EPaperImageModel> ePaperImageModels;

  EPaperModel({
    required this.date,
    required this.ePaperImageModels,
  });

  EPaperModel copyWith({
    String? date,
    List<EPaperImageModel>? ePaperImageModels,
  }) =>
      EPaperModel(
        date: date ?? this.date,
        ePaperImageModels: ePaperImageModels ?? this.ePaperImageModels,
      );

  factory EPaperModel.fromJson(Map<String, dynamic> json) => EPaperModel(
        date: json["date"],
        ePaperImageModels: List<EPaperImageModel>.from(
            json["e_paper_image_models"]
                .map((x) => EPaperImageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "e_paper_image_models":
            List<dynamic>.from(ePaperImageModels.map((x) => x.toJson())),
      };

  factory EPaperModel.empty() => EPaperModel(
        date: '',
        ePaperImageModels: [],
      );
}

class EPaperImageModel {
  int id;
  String imageLink;

  EPaperImageModel({
    required this.id,
    required this.imageLink,
  });

  EPaperImageModel copyWith({
    int? id,
    String? imageLink,
  }) =>
      EPaperImageModel(
        id: id ?? this.id,
        imageLink: imageLink ?? this.imageLink,
      );

  factory EPaperImageModel.fromJson(Map<String, dynamic> json) =>
      EPaperImageModel(
        id: json["id"],
        imageLink: json["image_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_link": imageLink,
      };

  factory EPaperImageModel.empty() => EPaperImageModel(
        id: 0,
        imageLink: '',
      );
}
