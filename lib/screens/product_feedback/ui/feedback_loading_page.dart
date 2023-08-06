import 'package:book_store/screens/product_feedback/ui/feedback_loading_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedbackLoadingPage extends StatelessWidget {
  const FeedbackLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sắp xếp theo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Shimmer.fromColors(
                baseColor: baseShimmer,
                highlightColor: highlightShimmer,
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: 140,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) {
              return Divider(
                height: 4,
                color: Colors.grey[100],
              );
            },
            itemBuilder: (context, index) {
              return const FeedbackLoadingItem();
            },
          ),
        ),
      ],
    );
  }
}
