import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 2,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[200]!,
              child: Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: Container(
              height: 12,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
