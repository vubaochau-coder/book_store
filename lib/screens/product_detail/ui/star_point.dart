import 'package:flutter/material.dart';

class StarPoint extends StatelessWidget {
  final int feedbackTotal;
  const StarPoint({super.key, required this.feedbackTotal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      width: 18 * 5,
      child: ListView.builder(
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star_border,
            color: Colors.amber,
            size: 18,
          );
        },
      ),
    );
  }
}
