import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransactionProduct extends StatelessWidget {
  final CartItemModel productData;
  const TransactionProduct({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: CachedNetworkImage(
              imageUrl: productData.imgUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productData.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'x${productData.count}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          Converter.convertNumberToMoney(
                              productData.priceBeforeDiscount),
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'đ',
                          style: TextStyle(
                            color: AppColors.themeColor,
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          Converter.convertNumberToMoney(productData.price),
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
