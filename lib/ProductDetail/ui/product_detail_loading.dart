import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailLoadingPage extends StatelessWidget {
  const ProductDetailLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: kToolbarHeight,
            width: double.infinity,
            color: Colors.white,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 2 -
                  kBottomNavigationBarHeight,
              width: double.infinity,
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              top: 10,
              bottom: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 18,
                    width: 264,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 18,
                    width: 88,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 18,
                    width: 164,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.only(bottom: 6),
              color: Colors.white,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
