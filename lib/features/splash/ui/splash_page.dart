import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/splash_get_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  SplashGetController getController = Get.put(SplashGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 25.h,
            color: AppColors.primary,
          ),
          Expanded(
            child: FadeTransition(
              opacity: getController.animationController,
              child: Center(
                child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/Himalayan Express___ PNG.png')),
              ),
            ),
          ),
          Container(
            height: 25.h,
            width: 100.w,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
