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

  Future<void> saveCategory() async {
    List<String> categoryNames = [];
    categoryNames.add("World History");
    categoryNames.add("UPSC");
    categoryNames.add("Uncategorized");
    categoryNames.add("Startup");
    categoryNames.add("Sports");
    categoryNames.add("Social Justice");
    categoryNames.add("Science and Tech");
    categoryNames.add("Press Release");
    categoryNames.add("Politics");
    categoryNames.add("Pir Panchal");
    categoryNames.add("National");
    categoryNames.add("More");
    categoryNames.add("Ladakh");
    categoryNames.add("Kashmir");
    categoryNames.add("JKSSB");
    categoryNames.add("JKPSC");
    categoryNames.add("Jammu Kashmir");
    categoryNames.add("Jammu");
    categoryNames.add("International Relations");
    categoryNames.add("International");
    categoryNames.add("Internal Security");
    categoryNames.add("Indian Society");
    categoryNames.add("Indian Polity");
    categoryNames.add("Indian History");
    categoryNames.add("Healthcare");
    categoryNames.add("Government Schemes");
    categoryNames.add("Geography");
    categoryNames.add("Featured");
    categoryNames.add("Ethics, Integrity and Aptitude");
    categoryNames.add("Environment");
    categoryNames.add("Entertainment");
    categoryNames.add("Edit/Opinion");
    categoryNames.add("Economy");
    categoryNames.add("Economics");
    categoryNames.add("Disaster Management");
    categoryNames.add("Current Affairs");
    categoryNames.add("Chenab Valley");
    categoryNames.add("Business");
    categoryNames.add("Ayurveda");
    categoryNames.add("Aspirants Corner");

    for (var categoryName in categoryNames) {
      ArticleCategoryModel articleCategoryModel = ArticleCategoryModel(
          id: (categoryNames.indexOf(categoryName) + categories.length + 1)
              .toString(),
          name: categoryName,
          categoryNumber:
              categoryNames.indexOf(categoryName) + categories.length + 1,
          requiresRegistration: false);

      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc((categoryNames.indexOf(categoryName) + categories.length + 1)
              .toString())
          .set(articleCategoryModel.toJson());
    }
  }
}
