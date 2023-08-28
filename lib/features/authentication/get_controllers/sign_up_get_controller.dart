import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_constants.dart';
import '../../../models/user_model.dart';
import '../../home/ui/home_page.dart';

class SignUpGetController extends GetxController {
  final _isPasswordVisible = false.obs;

  bool get isPasswordVisible => _isPasswordVisible.value;

  void togglePasswordVisibility() {
    _isPasswordVisible.toggle();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  Future<void> initiateSignUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    String email = emailController.text.trim();

    await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(email)
        .then((userCollection) async {
      if (userCollection.isNotEmpty) {
        Get.snackbar(
          'Error',
          'The email address is already in use.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        UserModel userModel = UserModel(
            id: email,
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: email,
            accountCreatedOn: DateTime.now(),
            isBlocked: false);

        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email, password: passwordController.text.trim())
            .then((value) async {
          await FirebaseFirestore.instance
              .collection(AppConstants.users)
              .doc(userModel.id)
              .set(userModel.toJson())
              .then((value) {
            Get.offAll(() => HomePage());
          });
        });
      }
    });
  }
}
