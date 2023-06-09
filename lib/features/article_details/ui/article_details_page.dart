import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:sizer/sizer.dart';

import '../../../models/article_model.dart';

class ArticleDetailsPage extends StatelessWidget {
  final ArticleModel articleModel;

  const ArticleDetailsPage({Key? key, required this.articleModel})
      : super(key: key);

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
            flexibleSpace: Image.network(
              articleModel.headlineImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.sp),
                child: Text(articleModel.title,
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.bold)),
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
                      data: articleModel.htmlText,
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: IconButton(
        onPressed: () {
          FlutterShareMe flutterShareMe = FlutterShareMe();
          flutterShareMe.shareToWhatsApp(
              imagePath: articleModel.headlineImageUrl,
              msg: articleModel.title);
        },
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.share),
            SizedBox(
              width: 4.w,
            ),
            const Text('Share')
          ],
        ),
      ),
    );
  }
}
