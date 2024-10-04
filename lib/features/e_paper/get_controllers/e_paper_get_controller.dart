import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:himalayan_express/helpers/date_time_helpers.dart';

import '../../../core/app_constants.dart';
import '../../../models/e_paper_model.dart';

class EPaperGetController extends GetxController {
  TextEditingController selectedDateController = TextEditingController();
  Rx<EPaperModel> ePaperModel = EPaperModel.empty().obs;

  carousel.CarouselSliderController carouselController =
      carousel.CarouselSliderController();

  RxInt currentIndex = 0.obs;

  bool get hasPreviousPage => currentIndex.value > 0;

  bool get hasNextPage =>
      currentIndex.value < ePaperModel.value.ePaperImageModels.length - 1;

  @override
  void onInit() {
    selectedDateController.text = DateTime.now().toDateWithShortMonthName;
    loadEPaper();
    super.onInit();
  }

  Future<void> loadEPaper() async {
    ePaperModel.value = EPaperModel.empty();
    await FirebaseFirestore.instance
        .collection(AppConstants.ePapers)
        .doc(selectedDateController.text)
        .get()
        .then((value) {
      if (value.exists) {
        ePaperModel.value =
            EPaperModel.fromJson(jsonDecode(jsonEncode(value.data())));
      } else {
        throw Exception('Failed to load document');
      }
    });
  }
}
