// features/cart/data/presentation/cart_list_builder.dart
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/cart/data/model/get_cart_response/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    super.key,
    required this.cartList,
    required this.onRemove,
    required this.onAddToCart,
  });
  final CartItem cartList;
  final Function() onRemove;
  final Function() onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cartList.itemProductImage ?? "",
                width: 100,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          cartList.itemProductName ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: gettitleTextStyle18(),
                        ),
                      ),
                      IconButton.outlined(
                        constraints:
                            const BoxConstraints(maxWidth: 24, maxHeight: 24),
                        onPressed: onRemove,
                        iconSize: 16,
                        padding: const EdgeInsets.all(2),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const Gap(5),
                  Text(
                    "\$ ${NumberFormat('#,##0.00').format(cartList.itemProductPriceAfterDiscount ?? cartList.itemProductPrice)}",
                    style: gettitleTextStyle16(),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      FloatingActionButton.small(
                        heroTag: '${cartList.itemId}+Add',
                        elevation: 0,
                        backgroundColor: AppColor.lightGrayColor,
                        onPressed: () {},
                        child: const Icon(Icons.remove),
                      ),
                      const Gap(10),
                      Text(
                        '01',
                        style: gettitleTextStyle18(),
                      ),
                      const Gap(10),
                      FloatingActionButton.small(
                        heroTag: '${cartList.itemId}-remove',
                        elevation: 0,
                        backgroundColor: AppColor.lightGrayColor,
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
