// features/home/presentation/widget/banner_widget.dart
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia/features/home/presentation/widget/popular_books.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetSlidersEvent());
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = 0;
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is GetSlidersLoadingState,
      builder: (context, state) {
        if (state is GetSlidersLoadingState) {
          var sliders = context.read<HomeBloc>().sliders;
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: sliders.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: sliders.isNotEmpty
                          ? Image.network(sliders[itemIndex].image ?? "")
                          : Image.asset(AppImages.book,
                              width: double.infinity, fit: BoxFit.cover));
                },
                options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.85,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPage = index;
                      });
                    }),
              ),
              const Gap(14),

              //smooth page indicator .....
              SmoothPageIndicator(
                  controller: PageController(
                      initialPage: currentPage), // PageController
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotColor: AppColor.lightGrayColor,
                    activeDotColor: AppColor.primaryColor,
                    dotHeight: 7,
                    dotWidth: 7,
                    expansionFactor: 5,
                  ), // your preferred effect
                  onDotClicked: (index) {})
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
          print("----------------");
        }
      },
    );
  }
}
