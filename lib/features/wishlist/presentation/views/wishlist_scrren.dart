// features/wishlist/presentation/views/wishlist_scrren.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia/features/home/presentation/pages/book_details.dart';
import 'package:bookia/features/wishlist/presentation/views/whishlistitem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetWhishListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetWishListLoadingState ||
            state is RemoveFromWishListLoadingState ||
            state is AddToCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is GetWishListLoadedState) {
          Navigator.pop(context);
        } else if (state is RemoveFromWishListLoadedState) {
          Navigator.pop(context);
          context.read<HomeBloc>().add(GetWhishListEvent());
        } else if (state is AddToCartLoadedState) {
          Navigator.pop(context);
          showErrorDialog(context, "Added to Cart", type: DialogType.success);
        }
      },
      builder: (context, state) {
        var whishlist = context.read<HomeBloc>().whishlist;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Wishlist',
              style: gettitleTextStyle26(),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: whishlist.isEmpty
                    ? Center(
                        child: Text(
                        'Your wishlist is empty',
                        style: gettitleTextStyle18(),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: ListView.separated(
                          itemCount: whishlist.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                //push to book details widget with product id
                                pushTo(
                                    context,
                                    BookDetails(
                                      product: whishlist[index],
                                    ));
                              },
                              child: whishlistitem(
                                product: whishlist[index],
                                onAddToCart: () {
                                  context.read<HomeBloc>().add(AddToCartEvent(
                                      productId: whishlist[index].id ?? 0));
                                },
                                onRemove: () {
                                  context.read<HomeBloc>().add(
                                      RemoveFromWhishListEvent(
                                          productId: whishlist[index].id ?? 0));
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
