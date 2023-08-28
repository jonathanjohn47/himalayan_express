import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/features/authentication/ui/sign_up_page.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/sign_in_get_controller.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  SignInGetController getController = Get.put(SignInGetController());

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
                              'Welcome Back',
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
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.offAll(() => SignUpPage());
                          },
                          child: const Text('Sign Up'),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0.sp),
                child: Card(
                  color: Colors.white,
                  elevation: 8.sp,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Column(
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getController.initiateSignIn();
                              },
                              style: ElevatedButton.styleFrom(elevation: 4.sp),
                              child: const Text('Sign In'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.sp),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
