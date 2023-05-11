import 'package:book_store/CustomWidget/product_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoadingState extends StatelessWidget {
  const CategoryLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            width: 120,
            height: 28,
            margin: const EdgeInsets.only(top: 8, bottom: 8, left: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return const ProductLoadingItem();
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
