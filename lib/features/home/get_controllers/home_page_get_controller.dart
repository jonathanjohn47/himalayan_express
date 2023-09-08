import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/article_model.dart';
import '../../../models/articles_from_rtdb.dart';
import '../../../models/category_model.dart';

class HomePageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<ArticleCategoryModel> categories = <ArticleCategoryModel>[].obs;

  RxInt selectedIndex = 0.obs;

  late TabController tabController;

  void loadCategories() async {
    FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .snapshots()
        .listen((value) {
      categories.value = value.docs
          .map((e) =>
              ArticleCategoryModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
      categories.sort((a, b) => a.categoryNumber.compareTo(b.categoryNumber));
      tabController = TabController(length: categories.length, vsync: this);
      tabController.addListener(() {
        selectedIndex.value = tabController.index;
      });
    });
  }

  @override
  void onInit() {
    loadCategories();
    Future.delayed(Duration(milliseconds: 500), () {
      loadArticleFromRtdb();
    });
    super.onInit();
  }

  Future<void> deleteDuplicateCategories() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((value) async {
      List<ArticleCategoryModel> allCategories = value.docs
          .map((e) =>
              ArticleCategoryModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
      List<ArticleCategoryModel> uniqueCategories = [];
      for (var category in allCategories) {
        int indexWhere = uniqueCategories.indexWhere((uniqueCategory) {
          return uniqueCategory.name == category.name;
        });
        if (indexWhere == -1) {
          uniqueCategories.add(category);
        }
      }
      for (var allCategory in allCategories) {
        await FirebaseFirestore.instance
            .collection(AppConstants.categories)
            .doc(allCategory.id)
            .delete();
      }
      for (var uniqueCategory in uniqueCategories) {
        ArticleCategoryModel newCategory = uniqueCategory.copyWith(
            id: '${uniqueCategories.indexOf(uniqueCategory) + 1}',
            categoryNumber: uniqueCategories.indexOf(uniqueCategory) + 1);
        await FirebaseFirestore.instance
            .collection(AppConstants.categories)
            .doc(newCategory.id)
            .set(newCategory.toJson());
      }
    });
  }

  Future<void> loadArticleFromRtdb() async {
    String firebaseUrl =
        "https://himalayanexpress-6288a-default-rtdb.asia-southeast1.firebasedatabase.app/";

    final response = await http.get(Uri.parse(firebaseUrl + "/Articles.json"));

    if (response.statusCode == 200) {
      Map<String, dynamic> articles = jsonDecode(response.body);

      articles.forEach((key, value) async {
        ArticlesFromRtdb temp = ArticlesFromRtdb.fromJson(value);
        List<String> receivedCategories = temp.category;
        for (String receivedCategory in receivedCategories) {
          int indexWhere = categories.indexWhere((category) =>
              category.name.toLowerCase() == receivedCategory.toLowerCase());
          if (indexWhere == -1) {
            ArticleCategoryModel categoryModel = ArticleCategoryModel(
                id: '${categories.length + 1}',
                name: receivedCategory,
                categoryNumber: categories.length + 1,
                requiresRegistration: false);

            await FirebaseFirestore.instance
                .collection(AppConstants.categories)
                .doc(categoryModel.id)
                .set(categoryModel.toJson());
          }
        }
      });
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
