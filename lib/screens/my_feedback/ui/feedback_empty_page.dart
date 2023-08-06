import 'package:flutter/material.dart';

class FeedbackEmptyPage extends StatelessWidget {
  const FeedbackEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 112,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.6,
                image: AssetImage(
                  'images/feedback.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Không có sản phẩm nào để đánh giá',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
