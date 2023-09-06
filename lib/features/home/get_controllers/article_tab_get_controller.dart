import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/article_model.dart';
import '../../../models/articles_from_rtdb.dart';
import '../../../models/category_model.dart';
import '../../../models/publisher_model.dart';

class ArticleTabGetController extends GetxController {
  Future<List<ArticleModel>> loadArticleFromRtdb() async {
    List<ArticleModel> articlesList = [];
    String firebaseUrl =
        "https://himalayanexpress-6288a-default-rtdb.asia-southeast1.firebasedatabase.app/";

    final response = await http.get(Uri.parse(firebaseUrl + "/Articles.json"));

    if (response.statusCode == 200) {
      Map<String, dynamic> articles = jsonDecode(response.body);

      articles.forEach((key, value) {
        ArticlesFromRtdb temp = ArticlesFromRtdb.fromJson(value);
        List<String> receivedCategories = temp.category;
        FirebaseFirestore.instance
            .collection(AppConstants.categories)
            .get()
            .then((categoriesValue) async {
          List<ArticleCategoryModel> allCategories = categoriesValue.docs
              .map((e) => ArticleCategoryModel.fromJson(
                  jsonDecode(jsonEncode(e.data()))))
              .toList();
          int categoryNumber = categoriesValue.docs.length;
          for (String receivedCategory in receivedCategories) {
            int indexWhere = allCategories.indexWhere((categoryInFirebase) {
              return categoryInFirebase.name == receivedCategory;
            });
            if (indexWhere == -1) {
              await FirebaseFirestore.instance
                  .collection(AppConstants.categories)
                  .doc(categoryNumber.toString())
                  .set(ArticleCategoryModel(
                          id: categoryNumber.toString(),
                          categoryNumber: categoryNumber,
                          name: receivedCategory,
                          requiresRegistration: false)
                      .toJson())
                  .then((value) async {
                categoryNumber++;
                await FirebaseFirestore.instance
                    .collection(AppConstants.categories)
                    .doc(categoryNumber.toString())
                    .get()
                    .then((value) {
                  allCategories.add(ArticleCategoryModel.fromJson(
                      jsonDecode(jsonEncode(value.data()))));
                  articlesList.add(ArticleModel(
                    id: key,
                    title: temp.title,
                    description: "",
                    // Fill as required
                    htmlText: temp.content,
                    // Fill as required
                    date: DateTime.fromMillisecondsSinceEpoch(temp.timestamp),
                    // Timestamp in Firebase is in milliseconds, convert to DateTime
                    headlineImageUrl: temp.thumbnailImageUrl,
                    // Fill as required
                    youtubeLink: "",
                    // Fill as required
                    category: allCategories[indexWhere],
                    // Pass the required values and create object
                    publisher: PublisherModel(
                        name: temp.publisherName,
                        email: "email",
                        password: "password",
                        profilePicLink: "",
                        dateCreated:
                            ""), // Pass the required values and create object
                  ));
                });
              });
            } else {
              articlesList.add(ArticleModel(
                id: key,
                title: temp.title,
                description: "",
                // Fill as required
                htmlText: temp.content,
                // Fill as required
                date: DateTime.fromMillisecondsSinceEpoch(temp.timestamp),
                // Timestamp in Firebase is in milliseconds, convert to DateTime
                headlineImageUrl: temp.thumbnailImageUrl,
                // Fill as required
                youtubeLink: "",
                // Fill as required
                category: allCategories[indexWhere],
                // Pass the required values and create object
                publisher: PublisherModel(
                    name: temp.publisherName,
                    email: "email",
                    password: "password",
                    profilePicLink: "",
                    dateCreated:
                        ""), // Pass the required values and create object
              ));
            }
          }
        });
      });
    } else {
      throw Exception("Failed to load articles");
    }

    return articlesList;
  }
}
