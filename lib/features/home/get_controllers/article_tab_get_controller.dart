import 'package:get/get.dart';
import 'package:himalayan_express/models/articles_from_rtdb.dart';
import 'package:himalayan_express/models/category_model.dart';
import 'package:http/http.dart' as http;

class ArticleTabGetController extends GetxController {
  Future<List<ArticlesFromRtdb>> loadArticleFromRtdb(
      ArticleCategoryModel categoryModel) async {
    List<ArticlesFromRtdb> articlesList = [];
    print(
        'https://himalayanexpress.in/wp-json/he/v1/category/${categoryModel.slug}');
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://himalayanexpress.in/wp-json/he/v1/category/${categoryModel.slug}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Response is 200");
      String responseString = await response.stream.bytesToString();
      print("Response String: $responseString");
      articlesList = articlesFromRtdbFromJson(responseString);
      print("Length of articlesList: ${articlesList.length}");
    } else {
      print(response.reasonPhrase);
    }

    return articlesList;
  }
}
