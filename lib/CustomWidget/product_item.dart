import 'package:book_store/models/product_data_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final ProductDataModel data;
  const ProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 4,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: data.imageURL[0],
              height: 140,
              fit: BoxFit.contain,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 140,
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              data.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'đ',
                  style: TextStyle(
                    color: themeColor,
                    decoration: TextDecoration.underline,
                    fontSize: 11,
                  ),
                ),
                Text(
                  Converter.convertNumberToMoney(
                      data.price - data.price * data.discount),
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Text(
                  'đ',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                      TextDecoration.lineThrough,
                    ]),
                    fontSize: 11,
                  ),
                ),
                Text(
                  Converter.convertNumberToMoney(data.price),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                // Icon(
                //   Icons.star_rounded,
                //   color: Colors.amber[400],
                //   size: 16,
                // ),
                // Text(
                //   data.star.toString(),
                //   style: const TextStyle(
                //     fontSize: 12,
                //   ),
                // ),
                const Spacer(),
                Text(
                  'Đã bán ${data.totalSold}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
