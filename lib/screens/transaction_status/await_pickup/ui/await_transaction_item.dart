import 'package:book_store/screens/transaction_status/ui/abstract_transaction_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class AwaitPickupTransactionItem extends AbstractTransactionItem {
  const AwaitPickupTransactionItem({
    super.key,
    required super.onTap,
    required super.transactionData,
  });

  @override
  Widget buildAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          margin: const EdgeInsets.only(top: 4),
          child: const Text(
            'Chờ lấy hàng',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildStatus() {
    return Text(
      'Chưa thanh toán',
      style: TextStyle(
        color: themeColor,
        fontSize: 12,
      ),
    );
  }
}
