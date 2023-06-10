import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_constants.dart';
import 'package:himalayan_express/features/home/ui/home_page.dart';

class SplashGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    signInTemporarily();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animationController.forward().then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => HomePage());
      });
    });
    super.onInit();
  }

  void signInTemporarily() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: AppConstants.emailForTemporaryLogin,
            password: AppConstants.passwordForTemporaryLogin)
        .then((value) {});
  }
}
