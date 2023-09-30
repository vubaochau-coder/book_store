import 'package:book_store/app_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoadingDropdown extends StatelessWidget {
  const CategoryLoadingDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseShimmer,
      highlightColor: AppColors.highlightShimmer,
      child: Container(
        width: 120,
        height: 28,
        margin: const EdgeInsets.only(top: 8, bottom: 8, left: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
