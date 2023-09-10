import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:book_store/screens/product_detail/ui/product_detail_page.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final ShortProductDataModel data;
  const ProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 4,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(8),
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () {
              Navigator.of(context).push(
                PageRouteSlideTransition(
                  child: ProductDetailPage(
                    productID: data.id,
                  ),
                ),
              );
            },
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: data.imgURL,
                    height: 140,
                    fit: BoxFit.contain,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: baseShimmer,
                        highlightColor: highlightShimmer,
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
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'đ',
                        style: TextStyle(
                          color: themeColor,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(
                            data.price * (1 - data.discount)),
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
