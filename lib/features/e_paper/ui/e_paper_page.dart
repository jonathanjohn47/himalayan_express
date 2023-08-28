import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/helpers/date_time_helpers.dart';
import 'package:sizer/sizer.dart';

import '../../view_image/ui/image_view.dart';
import '../get_controllers/e_paper_get_controller.dart';

class EPaperPage extends StatelessWidget {
  EPaperPage({super.key});

  EPaperGetController getController = Get.put(EPaperGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          getController.selectedDateController.text =
                              value.toDateWithShortMonthName;
                          getController.loadEPaper();
                        }
                      });
                    },
                    child: SizedBox(
                      width: 100.sp,
                      child: TextFormField(
                        enabled: false,
                        controller: getController.selectedDateController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                  ),
                  /*Obx(() {
                    return Row(
                      children: [
                        ...getController.ePaperModel.value.ePaperImageModels
                            .map((e) => IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  child: Text((e.id + 1).toString()),
                                )))
                      ],
                    );
                  })*/
                ],
              ),
              SizedBox(
                height: 5.sp,
              ),
              Expanded(
                child: Obx(() {
                  return CarouselSlider(
                      carouselController: getController.carouselController,
                      items: getController.ePaperModel.value.ePaperImageModels
                          .map((e) => GestureDetector(
                              onTap: () {
                                Get.to(() {
                                  return ImageView(
                                      heroTag: e.imageLink, image: e.imageLink);
                                });
                              },
                              child: Image.network(e.imageLink)))
                          .toList(),
                      options: CarouselOptions(
                          viewportFraction: 0.5,
                          height: 80.h,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.vertical));
                }),
              ),
              SizedBox(
                height: 5.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
