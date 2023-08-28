import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/features/authentication/ui/sign_in_page.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/sign_up_get_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  SignUpGetController getController = Get.put(SignUpGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 40.h, // You can set the height as per your need
                  color:
                      Theme.of(context).primaryColor, // Primary Color Container
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.all(16.0.sp),
                        child: Row(
                          children: [
                            Text(
                              'Welcome to Wanah Organic',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: Container(
                  width: double.infinity,

                  // You can set the height as per your need
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,

                  child: Padding(
                    padding: EdgeInsets.only(bottom: 32.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.offAll(() => SignInPage());
                          },
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 20.h,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 50.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0.sp),
                  child: Card(
                    color: Colors.white,
                    elevation: 8.sp,
                    child: Padding(
                      padding: EdgeInsets.all(16.0.sp),
                      child: ListView(
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          TextFormField(
                            controller: getController.firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          TextFormField(
                            controller: getController.lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          TextFormField(
                            controller: getController.emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          Obx(() {
                            return TextFormField(
                              controller: getController.passwordController,
                              obscureText: !getController.isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    getController.togglePasswordVisibility();
                                  },
                                  icon: const Icon(Icons.visibility),
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 10.sp),
                          TextFormField(
                            controller: getController.confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          ElevatedButton(
                            onPressed: () {
                              getController.initiateSignUp();
                            },
                            style: ElevatedButton.styleFrom(elevation: 4.sp),
                            child: const Text('Sign Up'),
                          ),
                          SizedBox(height: 10.sp),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
