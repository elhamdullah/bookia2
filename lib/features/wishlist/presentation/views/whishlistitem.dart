// features/wishlist/presentation/views/whishlistitem.dart

import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/home/data/model/response/get_arrivals_books_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class whishlistitem extends StatelessWidget {
  const whishlistitem({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onAddToCart,
  });
  final Product product;
  final Function() onRemove;
  final Function() onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.image ?? '',
            width: 100,
            height: 120,
            fit: BoxFit.cover,
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
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: gettitleTextStyle20(),
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
                '\$ ${product.priceAfterDiscount ?? product.price}',
                style: gettitleTextStyle16(),
              ),
              const Gap(20),
              CustomButton(
                text: 'Add to cart',
                onPressed: onAddToCart,
                textcolor: AppColor.whiteColor,
                fontsize: 18,
                height: 50,
              ),
              const Gap(10),
            ],
          ),
        )
      ],
    );
  }
}
