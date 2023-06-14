import 'package:book_store/ProductDetail/ui/star_point.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductHeader extends StatelessWidget {
  final String title;
  final double price;
  final double discount;
  final int totalFeedback;
  final int totalSold;

  const ProductHeader({
    super.key,
    required this.title,
    required this.price,
    required this.discount,
    required this.totalFeedback,
    required this.totalSold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
        top: 10,
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "${Converter.convertNumberToMoney(price * (1 - discount))} ",
                style: TextStyle(
                  color: themeColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'đ',
                style: TextStyle(
                  color: themeColor,
                  decoration: TextDecoration.underline,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "${Converter.convertNumberToMoney(price)} ",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
              Text(
                'đ',
                style: TextStyle(
                  decoration: TextDecoration.combine(
                    [
                      TextDecoration.lineThrough,
                      TextDecoration.underline,
                    ],
                  ),
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                child: Text(
                  '-${(discount * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              StarPoint(feedbackTotal: totalFeedback),
              Text(
                " $totalFeedback đánh giá",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Text(
                '${NumberFormat("###,##0").format(totalSold)} lượt bán',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
