import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_constants.dart';

import '../../../models/course_model.dart';

class CoursePageGetController extends GetxController {
  RxList<CourseModel> courseModels = <CourseModel>[].obs;

  void getCourses() {
    FirebaseFirestore.instance
        .collection(AppConstants.courses)
        .get()
        .then((value) {
      courseModels.value = value.docs
          .map((e) => CourseModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
    });
  }

  @override
  void onInit() {
    getCourses();
    super.onInit();
  }
}
