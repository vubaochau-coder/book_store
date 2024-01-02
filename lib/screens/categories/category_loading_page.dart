import 'package:book_store/custom_widgets/product_shimmer_item.dart';
import 'package:flutter/material.dart';

class CategoryLoadingPage extends StatelessWidget {
  const CategoryLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return const ProductLoadingItem();
      },
      itemCount: 10,
    );
  }
}
