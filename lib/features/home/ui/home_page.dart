import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_colors.dart';
import 'package:himalayan_express/features/authentication/ui/sign_in_page.dart';
import 'package:himalayan_express/features/e_paper/ui/e_paper_page.dart';
import 'package:himalayan_express/features/home/ui/articles_tab.dart';
import 'package:himalayan_express/features/search/ui/search_page.dart';
import 'package:himalayan_express/models/category_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
          backgroundColor: Colors.white,
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
                /*MaterialButton(
                  elevation: 4,
                  onPressed: () {
                    Get.to(() => EPaperPage());
                  },
                  child: Text('E-paper'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0.sp),
                      side: BorderSide(
                          color: AppColors.secondary, width: 1.5.sp)),
                ),*/
                IconButton(
                    onPressed: () {
                      Get.to(() => SearchPage());
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      Get.to(() => SignInPage());
                    },
                    icon: const Icon(Icons.person)),
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
                        return Container(
                          color: AppColors.primary,
                          child: TabBar(
                            controller: getController.tabController,
                            isScrollable: true,
                            tabs: [
                              ...getController.categories.map((e) => Tab(
                                    child: Text(
                                      e.name,
                                      style: TextStyle(
                                          fontSize: 11.sp, color: Colors.white),
                                    ),
                                  ))
                            ],
                            indicatorColor: Colors.white,
                          ),
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
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
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
                              ),
                              onTap: () {
                                getController.selectedIndex.value =
                                    getController.categories.indexOf(element);
                                getController.tabController.animateTo(
                                    getController.selectedIndex.value);
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
                ),
              );
            }),
          ),
          bottomNavigationBar: Container(
            color: AppColors.secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //home, contact, share
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Get.to(() => const ContactPage());
                    },
                    icon: const Icon(
                      Icons.contact_page,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Get.to(() => EPaperPage());
                    },
                    icon: Icon(
                      MdiIcons.newspaper,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
