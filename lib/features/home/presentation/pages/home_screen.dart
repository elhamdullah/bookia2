// features/home/presentation/pages/home_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia/features/home/presentation/pages/book_details.dart';
import 'package:bookia/features/home/presentation/widget/banner_widget.dart';
import 'package:bookia/features/home/presentation/widget/popular_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final searchBook = context.read<HomeBloc>().searchBooks;

        // Display search results
        if (state is SearchLoadedState) {
          
          return Scaffold(
            appBar: _buildAppBar(context),
            body: searchBook.isNotEmpty
                ? GridView.builder(
                    itemCount: searchBook.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 280,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          pushTo(
                              context,
                              BookDetails(
                                product: searchBook[index],
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: AppColor.seconderyColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                        child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Hero(
                                          tag: searchBook[index].id ?? 0,
                                          child: Image.network(
                                            searchBook[index].image ?? "",
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        //  "${booksList[index].discount}% Off",
                                        searchBook[index].discount != 0
                                            ? Positioned(
                                                child: badges.Badge(
                                                badgeAnimation: const badges
                                                    .BadgeAnimation.scale(
                                                  toAnimate: true,
                                                  // curve: Curves.ease,
                                                  loopAnimation: true,
                                                  animationDuration:
                                                      Duration(seconds: 1),
                                                  colorChangeAnimationCurve:
                                                      Curves.bounceIn,
                                                ),
                                                badgeStyle:
                                                    const badges.BadgeStyle(
                                                  badgeColor:
                                                      AppColor.seconderyColor,
                                                  shape:
                                                      badges.BadgeShape.square,
                                                ),
                                                badgeContent: Text(
                                                  "${searchBook[index].discount}% Off",
                                                  style: gettitleTextStyle18(),
                                                ),
                                              ))
                                            : const SizedBox(),
                                      ],
                                    ))),
                              ),
                              //

                              const Gap(10),
                              Text(
                                searchBook[index].name ?? "",
                                style: gettitleTextStyle16(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  Text(
                                    "${searchBook[index].priceAfterDiscount?.toStringAsFixed(1)} EGP",
                                    style: gettitleTextStyle14(),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                      child: CustomButton(
                                    bgcolor: AppColor.darkColor,
                                    textcolor: AppColor.whiteColor,
                                    text: 'Buy',
                                    height: 30,
                                    fontsize: 18,
                                    onPressed: () {
                                      context.read<HomeBloc>().add(
                                          AddToCartEvent(
                                              productId:
                                                  searchBook[index].id ?? 0));
                                    },
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No results found.'),
                  ),
          );
        }

        // Default state with no active search
        return Scaffold(
          appBar: _buildAppBar(context),
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
      },
    );
  }

  // Extracted AppBar for reuse
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: SvgPicture.asset(
        AppImages.logoSvg,
        height: 30,
      ),
      actions: [
        SizedBox(
          width: 300,
          child: SearchBar(
            enabled: true,
            hintText: "Search books",
            onChanged: (value) {
              if (value.isNotEmpty) {
                context.read<HomeBloc>().add(GetSearchBooksEvent(name: value));
              }
            },
          ),
        ),
      ],
    );
  }
}
