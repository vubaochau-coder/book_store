import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationLoadingItem extends StatelessWidget {
  const NotificationLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: baseShimmer,
            highlightColor: highlightShimmer,
            child: Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.only(right: 8, top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: baseShimmer,
                  highlightColor: highlightShimmer,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: const Text(
                            'Phiên bản thử nghiệm Phiên bản thử nghiệm',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 8,
                        width: 8,
                        margin: const EdgeInsets.only(left: 4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Shimmer.fromColors(
                  baseColor: baseShimmer,
                  highlightColor: highlightShimmer,
                  child: Container(
                    color: Colors.white,
                    child: const Text(
                      'Đây là project Đồ án môn học, nên tính năng này chưa thể hoàn thiện.\nIBOO xin chân thành cảm ơn bạn',
                      style: TextStyle(
                        height: 1.2,
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
