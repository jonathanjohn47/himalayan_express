import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(0.1),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(children: [
                Text(
                  'Name',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Text(
                  ':',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Text(
                  'Tahir Rufayee',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                ),
              ]),
              TableRow(children: [
                Text(
                  'Designation',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Text(
                  ':',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Text(
                  'Editor In Chief',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                ),
              ]),
              TableRow(children: [
                Text(
                  'Email',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Text(
                  ':',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                SelectableText(
                  'newsroom@himalayanexpress.in',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                ),
              ]),
              TableRow(children: [
                Text(
                  'Official Website',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Text(
                  ':',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('www.himalayanexpress.in'));
                  },
                  child: Text(
                    'www.himalayanexpress.in',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Colors.cyan),
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}
