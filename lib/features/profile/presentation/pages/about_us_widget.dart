// features/profile/presentation/pages/about_us_widget.dart
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coding Arabic",
                style: gettitleTextStyle30(),
              ),
              Image.asset(AppImages.aboutUSPng),
              Gap(20),
              Text(
                "At Ktaby Bookstore, we believe that books are the main resource for effective learning. We aim to provide technology and business books with affordable prices.",
                style: gettitleTextStyle20(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
