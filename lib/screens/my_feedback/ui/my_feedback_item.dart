import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/core/models/unfeedback_item_model.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyFeedbackItem extends StatelessWidget {
  final FeedbackItemModel itemModel;
  const MyFeedbackItem({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: itemModel.imgURL,
              fit: BoxFit.contain,
              height: 72,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemModel.bookTitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'đ',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      Converter.convertNumberToMoney(itemModel.price),
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
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
