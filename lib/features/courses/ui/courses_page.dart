import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get_controllers/course_page_get_controller.dart';

class CoursesPage extends StatelessWidget {
  CoursesPage({super.key});

  CoursePageGetController getController = Get.put(CoursePageGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemBuilder: (context, index) {
              final course = getController.courseModels[index];
              return ListTile(
                title: Text(course.name),
                subtitle: Text(
                    'Price: ${course.price}, Duration: ${course.durationInMonths} months'),
              );
            },
            itemCount: getController.courseModels.length,
          );
        },
      ),
    );
  }
}
