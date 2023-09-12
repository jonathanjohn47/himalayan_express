import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/article_model.dart';
import '../../../models/articles_from_rtdb.dart';
import '../../../models/publisher_model.dart';
import 'home_page_get_controller.dart';

class ArticleTabGetController extends GetxController {
  Future<List<ArticleModel>> loadArticleFromRtdb(String categoryName) async {
    List<ArticleModel> articlesList = [];
    String firebaseUrl =
        "https://himalayanexpress-6288a-default-rtdb.asia-southeast1.firebasedatabase.app/";

    final response = await http.get(Uri.parse(firebaseUrl + "/Articles.json"));

    if (response.statusCode == 200) {
      Map<String, dynamic> articles = jsonDecode(response.body);

      articles.forEach((key, value) {
        ArticlesFromRtdb temp = ArticlesFromRtdb.fromJson(value);
        List<String> receivedCategories = temp.category;
        HomePageGetController homePageGetController = Get.find();
        int indexWhere = homePageGetController.categories
            .indexWhere((element) => receivedCategories.contains(categoryName));
        if (indexWhere != -1) {
          articlesList.add(ArticleModel(
            id: temp.url,
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
            category: homePageGetController.categories[indexWhere],
            // Pass the required values and create object
            publisher: PublisherModel(
                name: temp.publisherName,
                email: "email",
                password: "password",
                profilePicLink: "",
                dateCreated: ""), // Pass the required values and create object
          ));
        }
      });
    } else {
      throw Exception("Failed to load articles");
    }

    return articlesList;
  }
}
