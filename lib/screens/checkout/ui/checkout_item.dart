import 'package:book_store/core/models/cart_item_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutItem extends StatelessWidget {
  final CartItemModel data;
  const CheckoutItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: CachedNetworkImage(
                imageUrl: data.imgUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: baseShimmer,
                    highlightColor: highlightShimmer,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'đ',
                        style: TextStyle(
                          color: themeColor,
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(data.price),
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'đ',
                        style: TextStyle(
                          decoration: TextDecoration.combine(
                            [
                              TextDecoration.lineThrough,
                              TextDecoration.underline,
                            ],
                          ),
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(
                            data.priceBeforeDiscount),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'x${data.count}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
