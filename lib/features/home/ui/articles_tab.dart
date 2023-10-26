import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayan_express/core/app_colors.dart';
import 'package:himalayan_express/helpers/date_time_helpers.dart';
import 'package:himalayan_express/models/articles_from_rtdb.dart';
import 'package:himalayan_express/models/category_model.dart';
import 'package:sizer/sizer.dart';

import '../../article_details/ui/article_details_page.dart';
import '../get_controllers/article_tab_get_controller.dart';

class ArticlesTab extends StatelessWidget {
  final ArticleCategoryModel categoryModel;

  ArticlesTab({super.key, required this.categoryModel});

  ArticleTabGetController getController = Get.put(ArticleTabGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<ArticlesFromRtdb>>(
            future: getController.loadArticleFromRtdb(categoryModel),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ArticlesFromRtdb> allArticles = snapshot.data!;

                return allArticles.length <= 5
                    ? ListView(
                        children: [
                          ...allArticles.map((e) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ArticleDetailsPage(
                                      articleModel: e,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.title,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4.sp),
                                            child:
                                                e.thumbnailImageUrl.isNotEmpty
                                                    ? Image.network(
                                                        e.thumbnailImageUrl,
                                                        fit: BoxFit.cover,
                                                        width: 20.w,
                                                        height: 20.w,
                                                      )
                                                    : Container()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Published: ${DateTime.fromMillisecondsSinceEpoch(e.timestamp * 1000).toDateWithShortMonthName}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Row(
                                      children: [

                                        Text(
                                          e.publisherName,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5.sp,
                                    color: AppColors.secondary.shade50
                                        .withOpacity(0.5),
                                    indent: 8.w,
                                    endIndent: 8.w,
                                  )
                                ],
                              ),
                            );
                          }).toList()
                        ],
                      )
                    : Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          CarouselSlider(
                              items: [
                                ...allArticles.sublist(0, 5).map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ArticleDetailsPage(
                                            articleModel: e,
                                          ));
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(
                                          e.thumbnailImageUrl,
                                          fit: BoxFit.cover,
                                          width: 100.w,
                                        ),
                                        Positioned(
                                          bottom: 16.sp,
                                          child: Container(
                                            height: 20.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.9)
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.sp),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      e.title,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            blurRadius: 3.0,
                                                            color: Colors.black,
                                                            offset: Offset(
                                                                2.0, 2.0),
                                                          ),
                                                        ],
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.sp,
                                                  ),
                                                  Text(
                                                    "Published: ${DateTime.fromMillisecondsSinceEpoch(e.timestamp * 1000).toDateWithShortMonthNameAndTime}",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  height: 35.h,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3))),
                          Padding(
                            padding: EdgeInsets.only(top: 31.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.sp),
                                  topRight: Radius.circular(16.sp),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.7),
                                    spreadRadius: 1.sp,
                                    blurRadius: 1.sp,
                                    offset: Offset(0, -1.5.sp),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0.sp, left: 8.0.sp, right: 8.0.sp),
                                child: ListView(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => ArticleDetailsPage(
                                              articleModel: allArticles[5],
                                            ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0.sp),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4.sp),
                                                child: Image.network(
                                                  allArticles[5]
                                                      .thumbnailImageUrl,
                                                  fit: BoxFit.cover,
                                                  width: 100.w,
                                                  height: 25.h,
                                                )),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: AutoSizeText(
                                                    allArticles[5].title,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 0.5.sp,
                                      color: AppColors.secondary.shade50
                                          .withOpacity(0.5),
                                      indent: 8.w,
                                      endIndent: 8.w,
                                    ),
                                    ...allArticles
                                        .sublist(6, allArticles.length)
                                        .map((e) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(e.toJson());
                                          Get.to(() => ArticleDetailsPage(
                                                articleModel: e,
                                              ));
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.sp),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      e.title,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.sp),
                                                    child: e.thumbnailImageUrl
                                                            .isNotEmpty
                                                        ? Image.network(
                                                            e.thumbnailImageUrl,
                                                            fit: BoxFit.cover,
                                                            width: 20.w,
                                                            height: 20.w,
                                                          )
                                                        : Container(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.sp),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Published: ${DateTime.fromMillisecondsSinceEpoch(e.timestamp * 1000).toDateWithShortMonthNameAndTime}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 0.5.sp,
                                              color: AppColors.secondary.shade50
                                                  .withOpacity(0.5),
                                              indent: 8.w,
                                              endIndent: 8.w,
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
