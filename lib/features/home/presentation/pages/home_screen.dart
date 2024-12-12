// features/home/presentation/pages/home_screen.dart
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/icons.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/home/presentation/widget/banner_widget.dart';
import 'package:bookia/features/home/presentation/widget/popular_books.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppImages.logoSvg,
          height: 30,
        ),
        actions: [
          SvgPicture.asset(AppIcons.search),
          const Gap(16),
          SvgPicture.asset(
            AppIcons.notification,
          ),
          const Gap(12)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //slider
            const Gap(20),
            BannerWidget(),

            //GridView
            const Gap(10),
            PopularBooks(),
          ],
        ),
      ),
    );
  }
}
