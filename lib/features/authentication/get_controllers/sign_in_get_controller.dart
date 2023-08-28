import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/ui/home_page.dart';


class SignInGetController extends GetxController {
  final _isPasswordVisible = false.obs;

  bool get isPasswordVisible => _isPasswordVisible.value;

  void togglePasswordVisibility() {
    _isPasswordVisible.toggle();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initiateSignIn() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;

      if (user != null) {
        Get.offAll(() =>  HomePage());
      } else {
        Get.snackbar('Error', 'Sign in failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
