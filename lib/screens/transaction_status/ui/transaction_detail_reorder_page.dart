import 'package:book_store/screens/transaction_status/ui/abstract_transaction_detail_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class ReOrderTransactionDetailPage extends AbstractTransactionDetailPage {
  final VoidCallback onReOrder;
  const ReOrderTransactionDetailPage({
    super.key,
    required super.transactionData,
    required this.onReOrder,
  });

  @override
  Widget buildAction(context) {
    return Container(
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      color: Colors.white,
      child: ElevatedButton(
        onPressed: onReOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor,
          elevation: 0,
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
    );
  }
}
