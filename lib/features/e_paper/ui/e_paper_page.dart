import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_colors.dart';
import 'package:himalayan_express/helpers/date_time_helpers.dart';
import 'package:sizer/sizer.dart';

import '../../view_image/ui/image_view.dart';
import '../get_controllers/e_paper_get_controller.dart';

class EPaperPage extends StatelessWidget {
  EPaperPage({super.key});

  EPaperGetController getController = Get.put(EPaperGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.sp,
                  blurRadius: 5.sp,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100.sp,
                    child: TextFormField(
                      enabled: false,
                      controller: getController.selectedDateController,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
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
                      icon: Icon(Icons.calendar_month))
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/Himalayan Express___ PNG.png',
                    height: 8.h,
                  ),
                ],
              ),
              SizedBox(
                height: 5.sp,
              ),
              Expanded(
                child: Obx(() {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                        carouselController: getController.carouselController,
                        items: getController.ePaperModel.value.ePaperImageModels
                            .map((e) => GestureDetector(
                            onTap: () {
                              Get.to(() {
                                return ImageView(
                                  heroTag: e.imageLink,
                                  image: e.imageLink,
                                );
                              });
                            },
                            child: Image.network(e.imageLink)))
                            .toList(),
                        options: CarouselOptions(
                          viewportFraction: 0.5,
                          height: 80.h,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            getController.currentIndex.value = index;
                            getController.update();
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            shape: CircleBorder(),
                            onPressed: getController.hasPreviousPage
                                ? () => getController.carouselController
                                .previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear,
                            )
                                : null,
                            child: Icon(Icons.chevron_left),
                            backgroundColor: getController.hasPreviousPage
                                ? AppColors.primary.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.2),
                            elevation: 0,
                          ),
                          FloatingActionButton(
                            shape: CircleBorder(),
                            onPressed: getController.hasNextPage
                                ? () =>
                                getController.carouselController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                )
                                : null,
                            child: Icon(Icons.chevron_right),
                            backgroundColor: getController.hasNextPage
                                ? AppColors.primary.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.2),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    getController.ePaperModel.value.ePaperImageModels.length,
                        (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.all(2),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: index == getController.currentIndex.value ? AppColors.primary : Colors.grey,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
