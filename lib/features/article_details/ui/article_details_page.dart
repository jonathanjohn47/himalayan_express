import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himalayan_express/core/app_colors.dart';
import 'package:himalayan_express/helpers/date_time_helpers.dart';
import 'package:himalayan_express/models/articles_from_rtdb.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ArticleDetailsPage extends StatelessWidget {
  final ArticlesFromRtdb articleModel;

  ArticleDetailsPage({Key? key, required this.articleModel}) : super(key: key);

  late YoutubePlayerController youtubePlayerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), child: Container()),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            automaticallyImplyLeading: false,
            expandedHeight: 30.h,
            flexibleSpace: articleModel.thumbnailImageUrl.isEmpty
                ? Image.asset(
                    'assets/images/Himalayan Express___ PNG.png')
                : Image.network(articleModel.thumbnailImageUrl),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(articleModel.title,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Published By:',
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.grey)),
                        SizedBox(
                          width: 4.sp,
                        ),
                        Text(
                          articleModel.publisherName,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Date:',
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.grey)),
                        SizedBox(
                          width: 4.sp,
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  articleModel.timestamp * 1000)
                              .toDateWithShortMonthNameAndTime,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Divider(
                      thickness: 0.5.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                  child: SingleChildScrollView(
                    child: Html(
                      data: articleModel.content,
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.sp),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.share,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  Text(
                    "Share",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                /*FlutterShareMe().shareToSystem(msg: articleModel.url);*/
              },
            ),
          ),
        ],
      ),
    );
  }
}
