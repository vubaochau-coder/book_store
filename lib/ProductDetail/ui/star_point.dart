import 'package:flutter/material.dart';

class StarPoint extends StatelessWidget {
  final double star;
  const StarPoint({super.key, required this.star});

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
          if (index + 1 <= star.toInt()) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 18,
            );
          } else if (star - star.truncate() > 0) {
            return const Icon(
              Icons.star_half_outlined,
              color: Colors.amber,
              size: 18,
            );
          } else {
            return const Icon(
              Icons.star_border,
              color: Colors.amber,
              size: 18,
            );
          }
        },
      ),
    );
  }
}
