// features/home/presentation/pages/book_details.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/icons.dart';
import 'package:bookia/features/home/data/model/response/get_arrivals_books_response/product.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.product});
  final Product product;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final String finalDescription =
        widget.product.description?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '';
    bool isFound() {
      final whishlist = context.read<HomeBloc>().whishlist;
      final isProductInWishlist =
          whishlist.any((element) => element.id == widget.product.id);

      return isProductInWishlist;
    }

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AddToWishListLoadingState) {
          showLoadingDialog(context);
        } else if (state is AddToWishListLoadedState) {
          Navigator.pop(context);
          showErrorDialog(context, "Added to Wishlist",
              type: DialogType.success);
          context.read<HomeBloc>().add(GetWhishListEvent());
        } else if (state is RemoveFromWishListLoadedState) {
          showErrorDialog(context, "Removed from Wishlist",
              type: DialogType.success);
          context.read<HomeBloc>().add(GetWhishListEvent());
        } else if (state is AddToCartLoadedState) {
          Navigator.pop(context);
          showErrorDialog(context, "Added to Cart", type: DialogType.success);
          context.read<HomeBloc>().add(GetCartEvent());
        }
      },
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  if (isFound()) {
                    context.read<HomeBloc>().add(RemoveFromWhishListEvent(
                        productId: widget.product.id ?? 0));
                  } else {
                    context.read<HomeBloc>().add(
                        AddToWhishListEvent(productId: widget.product.id ?? 0));
                  }
                },
                child: SvgPicture.asset(
                  AppIcons.BookmarkSvg,
                  height: 35,
                  color: isFound() ? Colors.red : AppColor.blackColor,
                ),
              ),
              const Gap(10),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Hero(
                            tag: 'book-${widget.product.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.product.image ?? '',
                                fit: BoxFit.cover,
                                width: 210,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const Gap(15),
                          Text(
                            widget.product.name ?? 'Unknown Title',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: gettitleTextStyle30(),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(10),
                          Text(
                            widget.product.category ?? 'Unknown Category',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: gettitleTextStyle16(
                                color: AppColor.primaryColor),
                          ),
                          const Gap(10),
                          Text(
                            finalDescription,
                            textAlign: TextAlign.justify,
                            style: gettitleTextStyle16(),
                          ),
                          const Gap(100),
                        ],
                      ),
                    ),
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Text(
                        '${widget.product.price ?? '0.00'} EGP',
                        style: gettitleTextStyle20(),
                      ),
                      const Spacer(),
                      CustomButton(
                        bgcolor: AppColor.blackColor,
                        height: 50,
                        width: 200,
                        text: 'Add To Cart',
                        textcolor: AppColor.whiteColor,
                        fontsize: 20,
                        onPressed: () => context.read<HomeBloc>().add(
                            AddToCartEvent(productId: widget.product.id ?? 0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
