import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_colors.dart';
import 'package:himalayan_express/features/home/ui/articles_tab.dart';
import 'package:himalayan_express/features/search/ui/search_page.dart';
import 'package:himalayan_express/models/category_model.dart';
import 'package:sizer/sizer.dart';

import '../../contact/ui/contact_page.dart';
import '../get_controllers/home_page_get_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomePageGetController getController = Get.put(HomePageGetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
        length: getController.categories.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            title: Row(
              children: [
                Image.asset(
                  'assets/images/Himalayan Express___ PNG.png',
                  width: 30.w,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Get.to(() => SearchPage());
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
              ],
            ),
          ),
          body: Obx(() {
            return getController.categories.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Obx(() {
                        return TabBar(
                          controller: getController.tabController,
                          isScrollable: true,
                          tabs: [
                            ...getController.categories.map((e) => Tab(
                                  child: Text(
                                    e.name,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ))
                          ],
                          indicatorColor: AppColors.secondary,
                        );
                      }),
                      Expanded(
                        child: Obx(() {
                          return TabBarView(
                              controller: getController.tabController,
                              children: [
                                ...getController.categories
                                    .map((e) => ArticlesTab(
                                          categoryModel: e,
                                        ))
                              ]);
                        }),
                      )
                    ],
                  );
          }),
          drawer: Drawer(
            child: Obx(() {
              return Column(
                children: [
                  Container(
                    height: 25.h,
                    width: 100.w,
                    child: SafeArea(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: Image.asset(
                          'assets/images/Himalayan Express___ PNG.png'),
                    )),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      ArticleCategoryModel element =
                          getController.categories[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              element.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              getController.selectedIndex.value =
                                  getController.categories.indexOf(element);
                              getController.tabController
                                  .animateTo(getController.selectedIndex.value);
                              Navigator.pop(context);
                            },
                          ),
                          Divider(
                            thickness: 0.5.sp,
                            color: AppColors.secondary.withOpacity(0.5),
                            indent: 5.w,
                            endIndent: 5.w,
                          )
                        ],
                      );
                    },
                    itemCount: getController.categories.length,
                  ))
                ],
              );
            }),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //home, contact, share
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home_filled,
                        color: AppColors.primary,
                      )),
                  Text('Home', style: TextStyle(color: AppColors.primary)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => const ContactPage());
                      },
                      icon: Icon(
                        Icons.contact_page,
                        color: AppColors.primary,
                      )),
                  Text('Contact', style: TextStyle(color: AppColors.primary)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: AppColors.primary,
                      )),
                  Text('Share', style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
