import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedbackLoadingItem extends StatelessWidget {
  const FeedbackLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: baseShimmer,
              highlightColor: highlightShimmer,
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: baseShimmer,
                      highlightColor: highlightShimmer,
                      child: Container(
                        color: Colors.white,
                        child: const Text(
                          'hirusakunasaga@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: baseShimmer,
                      highlightColor: highlightShimmer,
                      child: Container(
                        color: Colors.white,
                        child: const Text(
                          '12/12/2022',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: baseShimmer,
                  highlightColor: highlightShimmer,
                  child: Container(
                    color: Colors.white,
                    child: const Text(
                      'Sản phẩm chất lượng rất tốt, đây là lần 2 mình',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: baseShimmer,
                  highlightColor: highlightShimmer,
                  child: Container(
                    color: Colors.white,
                    child: const Text(
                      'Sản phẩm chất lượng rất tốt, đây là lần 2 mình',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
