import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationLoadingItem extends StatelessWidget {
  const NotificationLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
            offset: Offset(0, 1),
          )
        ],
      ),
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
                Container(
                  height: 8,
                  width: 8,
                  margin: const EdgeInsets.only(right: 6, top: 4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
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
                '04:11 13/06/2023',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
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
    );
  }
}
