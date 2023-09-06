import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_constants.dart';

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
    super.onInit();
  }

  void changeCategoryFieldInArticles() {
    FirebaseFirestore.instance
        .collection(AppConstants.articles)
        .get()
        .then((value) {
      for (var article in value.docs) {}
    });
  }
}
