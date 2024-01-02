import "../../ui/abstract_transaction_item.dart";
import 'package:book_store/theme.dart';
import 'package:book_store/utils/date_time.dart';
import 'package:flutter/material.dart';

class DeliveringItem extends AbstractTransactionItem {
  final VoidCallback onReceived;
  const DeliveringItem({
    super.key,
    required super.onTap,
    required super.transactionData,
    required this.onReceived,
  });

  @override
  Widget buildAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Nhận sản phẩm muộn nhất vào ${DateTimeUtils.orderTime(transactionData.dateCompleted)}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: onReceived,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              backgroundColor: themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'Đã nhận được hàng',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildStatus() {
    return Text(
      'Đang giao hàng',
      style: TextStyle(
        color: themeColor,
      ),
    );
  }
}
