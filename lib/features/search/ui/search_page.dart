import 'package:himalayan_express/core/app_colors.dart';
import 'package:himalayan_express/helpers/date_time_helpers.dart';
import 'package:himalayan_express/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../models/article_model.dart';
import '../../article_details/ui/article_details_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.sp),
                        borderSide: BorderSide.none),
                    fillColor: AppColors.primary.shade50.withOpacity(0.15),
                    filled: true),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder<List<ArticleModel>>(
                      future: Future.delayed(const Duration(seconds: 2), () {
                        return List.generate(
                            15,
                            (index) => ArticleModel(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                title:
                                    'Article $index You’ve probably heard of Lorem Ipsum before – it’s the most-used dummy text excerpt out there.',
                                description: 'description',
                                htmlText:
                                    """<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>""",
                                date: DateTime.now(),
                                headlineImageUrl:
                                    'https://picsum.photos/200/300',
                                category: ArticleCategoryModel(
                                    id: index.toString(),
                                    name: 'Business',
                                    categoryNumber: index)));
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ArticleModel> allArticles = snapshot.data!;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                            child: Column(
                              children: [
                                ...allArticles.map((e) {
                                  return StreamBuilder<String>(
                                      stream: Stream.periodic(
                                          const Duration(milliseconds: 1), (_) {
                                        return searchController.text;
                                      }),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Visibility(
                                            visible: e.title
                                                .toLowerCase()
                                                .contains(snapshot.data!
                                                    .toLowerCase()),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(() => ArticleDetailsPage(
                                                      articleModel: e,
                                                    ));
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.sp),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            e.title,
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.sp),
                                                            child:
                                                                Image.network(
                                                              e.headlineImageUrl,
                                                              fit: BoxFit.cover,
                                                              width: 20.w,
                                                              height: 20.w,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.sp),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Published: ${e.date.toDateWithShortMonthNameAndTime}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 10.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 0.5.sp,
                                                    color: AppColors
                                                        .secondary.shade50
                                                        .withOpacity(0.5),
                                                    indent: 8.w,
                                                    endIndent: 8.w,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });
                                }).toList()
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
