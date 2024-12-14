// features/home/presentation/widget/popular_books.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/home/data/model/response/get_arrivals_books_response/product.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia/features/home/presentation/pages/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:badges/badges.dart' as badges;

class PopularBooks extends StatefulWidget {
  PopularBooks({super.key, this.product});

  final Product? product;

  @override
  State<PopularBooks> createState() => _PopularBooksState();
}

class _PopularBooksState extends State<PopularBooks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetNewArrivalsBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is NewArrivalsBooksLoadedState ||
          current is NewArrivalsBooksLoadingState,
      builder: (context, state) {
        if (state is NewArrivalsBooksLoadedState ||
            state is NewArrivalsBooksLoadedState) {
          var booksList = context.read<HomeBloc>().newArrivalBooks;
          bool isFound() {
            final whishlist = context.read<HomeBloc>().whishlist;
            final isProductInWishlist =
                whishlist.any((element) => element.id == widget.product?.id);

            return isProductInWishlist;
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Popular Books", style: gettitleTextStyle24()),
                const Gap(10),
                GridView.builder(
                  itemCount: booksList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              product: booksList[index],
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
                                        tag: booksList[index].id ?? 0,
                                        child: Image.network(
                                          booksList[index].image ?? "",
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      //  "${booksList[index].discount}% Off",
                                      booksList[index].discount != 0
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
                                                shape: badges.BadgeShape.square,
                                              ),
                                              badgeContent: Text(
                                                "${booksList[index].discount}% Off",
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
                              booksList[index].name ?? "",
                              style: gettitleTextStyle16(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Text(
                                  "${booksList[index].priceAfterDiscount?.toStringAsFixed(1)} EGP",
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
                                    context.read<HomeBloc>().add(AddToCartEvent(
                                        productId: booksList[index].id ?? 0));
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
              ],
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ));
        }
      },
      listener: (BuildContext context, HomeState state) {
        if (state is AddToCartLoadingState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          showErrorDialog(context, "Added to cart successfully",
              type: DialogType.success);
        }
      },
    );
  }
}
