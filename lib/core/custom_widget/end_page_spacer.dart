// core/custom_widget/end_page_spacer.dart
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EndPageTitle extends StatelessWidget {
  EndPageTitle(
      {super.key,
      required this.text,
      required this.btntext,
      required this.pushPage});

  String text;
  String btntext;
  Widget pushPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: gettitleTextStyle15(),
        ),
        TextButton(
          onPressed: () {
            pushTo(context, pushPage);
          },
          child: Text(
            btntext,
            style: gettitleTextStyle16(color: AppColor.primaryColor),
          ),
        ),
      ],
    );
  }
}
