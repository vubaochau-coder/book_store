import 'package:book_store/Transaction/ui/abstract_transaction_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class UnconfirmedTransactionItem extends AbstractTransactionItem {
  const UnconfirmedTransactionItem({
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
            'Chờ xác nhận',
            style: TextStyle(
              color: Colors.white,
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
      ),
    );
  }
}
