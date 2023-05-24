import 'package:book_store/Transaction/ui/abstract_transaction_detail_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class ReceivedTransactionDetailPage extends AbstractTransactionDetailPage {
  final VoidCallback onReceive;
  const ReceivedTransactionDetailPage({
    super.key,
    required super.transactionData,
    required this.onReceive,
  });

  @override
  Widget buildAction(context) {
    return Container(
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      color: Colors.white,
      child: ElevatedButton(
        onPressed: onReceive,
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor,
          elevation: 0,
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
    );
  }
}
