import 'package:book_store/screens/transaction_status/ui/abstract_transaction_item.dart';
import 'package:book_store/theme.dart';
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
            'Nhận sản phẩm muộn nhất vào ${transactionData.dateCompleted}',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.only(top: 4),
          child: ElevatedButton(
            onPressed: onReceived,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              backgroundColor: themeColor,
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
