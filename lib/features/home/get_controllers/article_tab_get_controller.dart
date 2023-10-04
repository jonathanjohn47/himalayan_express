import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:himalayan_express/models/articles_from_rtdb.dart';
import 'package:himalayan_express/models/category_model.dart';

class ArticleTabGetController extends GetxController {
  Future<List<ArticlesFromRtdb>> loadArticleFromRtdb(
      ArticleCategoryModel categoryModel) async {
    List<ArticlesFromRtdb> articlesList = [];

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://himalayanexpress.in/wp-json/mywebsite/v1/articles/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      List<dynamic> jsonList = json.decode(responseBody);

      articlesList = jsonList
          .map((e) => ArticlesFromRtdb.fromJson(jsonDecode(jsonEncode(e))))
          .toList();
      articlesList.removeWhere((article) => !article.category.any((category) =>
          category.toLowerCase().trim() ==
          categoryModel.name.toLowerCase().trim()));
    } else {
      print(response.reasonPhrase);
    }

    return articlesList;
  }
}
