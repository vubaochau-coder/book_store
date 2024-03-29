import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class CancelledConfirmDialog extends StatelessWidget {
  final VoidCallback onCancelTap;
  const CancelledConfirmDialog({super.key, required this.onCancelTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: Colors.amber[900],
            size: 22,
          ),
          Text(
            ' HỦY ĐƠN HÀNG',
            style: TextStyle(
              color: themeColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      contentPadding:
          const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 20),
      actions: [
        SizedBox(
          width: 120,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Hủy bỏ',
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton(
            onPressed: onCancelTap,
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: themeColor,
            ),
            child: const Text(
              'Hủy đơn',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Lưu ý: Đơn hàng bị hủy không thể hoàn tác',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Bạn có muốn tiếp tục?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: themeColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
