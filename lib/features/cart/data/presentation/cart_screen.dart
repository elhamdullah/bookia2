// features/cart/data/presentation/cart_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/cart/data/model/get_cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/features/cart/data/presentation/cart_list_builder.dart';
import 'package:bookia/features/cart/data/presentation/checkout_view.dart';
import 'package:bookia/features/home/data/model/response/get_arrivals_books_response/product.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia/features/home/presentation/pages/book_details.dart';
import 'package:bookia/features/wishlist/presentation/views/whishlistitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetCartLoadingState ||
            state is RemoveFromCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is GetCartLoadedState) {
          Navigator.pop(context);
        } else if (state is RemoveFromCartLoadedState) {
          Navigator.pop(context);
          context.read<HomeBloc>().add(GetCartEvent());
        }
      },
      builder: (context, state) {
        var cart = context.read<HomeBloc>().cartResponse;
        return Scaffold(
          appBar: AppBar(
            title: Text('My Cart', style: gettitleTextStyle26()),
            centerTitle: true,
          ),
          body: cart?.data?.cartItems?.isEmpty == true
              ? Center(
                  child: Text(
                  'Your Cart is empty',
                  style: gettitleTextStyle18(),
                ))
              : whishlistBuilder(cart?.data?.cartItems ?? []),
        );
      },
    );
  }

  whishlistBuilder(List<CartItem> cartList) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: ListView.separated(
              itemCount: cartList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return CartListItem(
                  cartList: cartList[index],
                  onAddToCart: () {},
                  onRemove: () {
                    context.read<HomeBloc>().add(
                          RemoveFromCartEvent(
                            productId: cartList[index].itemProductId ?? 0,
                          ),
                        );
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: gettitleTextStyle24(color: AppColor.grayColor),
                  ),
                  Text(
                    "\$ ${context.read<HomeBloc>().cartResponse?.data?.total}",
                    style: gettitleTextStyle24(color: AppColor.blackColor),
                  ),
                ],
              ),
              const Gap(10),
              CustomButton(
                text: 'Checkout',
                fontsize: 22,
                textcolor: AppColor.whiteColor,
                onPressed: () {
                  var totalPrice =
                      context.read<HomeBloc>().cartResponse?.data?.total;
                  pushTo(context,
                      CheckoutView(totalPrice: totalPrice?.toString() ?? "0"));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
