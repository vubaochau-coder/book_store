import 'package:book_store/screens/transaction_status/ui/abstract_transaction_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class CancelledItem extends AbstractTransactionItem {
  final VoidCallback onReOrder;
  const CancelledItem({
    super.key,
    required super.onTap,
    required super.transactionData,
    required this.onReOrder,
  });

  @override
  Widget buildAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
    return Row(
      children: [
        Text(
          'Đã hủy',
          style: TextStyle(
            color: themeColor,
            fontSize: 12,
          ),
        ),
        Icon(
          Icons.close,
          color: themeColor,
          size: 16,
        ),
      ],
    );
  }
}
