import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 4,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Column(
          children: [
            Image.asset(
              'images/product.png',
              height: 140,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              'Sách Tuổi Trẻ Đáng Giá Bao Nhiêu',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'đ',
                  style: TextStyle(
                    color: themeColor,
                    decoration: TextDecoration.underline,
                    fontSize: 11,
                  ),
                ),
                Text(
                  '65.000',
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber[400],
                  size: 16,
                ),
                const Text(
                  '4.9',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Đã bán 1,5k',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
