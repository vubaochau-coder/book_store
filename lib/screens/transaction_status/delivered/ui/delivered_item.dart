import 'package:book_store/screens/transaction_status/ui/abstract_transaction_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class DeliveredItem extends AbstractTransactionItem {
  final VoidCallback onReOrder;
  const DeliveredItem({
    super.key,
    required super.onTap,
    required super.transactionData,
    required this.onReOrder,
  });

  @override
  Widget buildAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            'Đơn hàng được giao vào ngày\n${transactionData.dateCompleted}',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          height: 36,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 4),
          child: ElevatedButton(
            onPressed: onReOrder,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              backgroundColor: themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'Mua lại',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildStatus() {
    return Row(
      children: [
        Text(
          'Hoàn thành',
          style: TextStyle(
            color: Colors.green[600],
          ),
        ),
        Icon(
          Icons.check,
          color: Colors.green[600],
          size: 16,
        ),
      ],
    );
  }
}
