import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/features/courses/ui/course_details_registration.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/course_page_get_controller.dart';

class CoursesPage extends StatelessWidget {
  CoursesPage({super.key});

  CoursePageGetController getController = Get.put(CoursePageGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a course'),
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemBuilder: (context, index) {
              final course = getController.courseModels[index];
              return ListTile(
                title: Text(course.name,
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w500)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ${course.price}'),
                    Text('Duration: ${course.durationInMonths} months'),
                  ],
                ),
                onTap: () {
                  Get.to(
                      () => CourseDetailsRegistrationPage(courseModel: course));
                },
              );
            },
            itemCount: getController.courseModels.length,
          );
        },
      ),
    );
  }
}
