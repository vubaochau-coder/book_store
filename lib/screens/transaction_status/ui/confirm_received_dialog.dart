import 'package:book_store/app_themes/app_colors.dart';
// import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class ReceivedConfirmDialog extends StatelessWidget {
  const ReceivedConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.themeColor,
            size: 22,
          ),
          Text(
            ' ĐÃ NHẬN ĐƠN HÀNG',
            style: TextStyle(
              color: AppColors.themeColor,
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
              Navigator.pop(context, false);
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
            child: Text(
              'Hủy bỏ',
              style: TextStyle(
                color: AppColors.themeColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: AppColors.themeColor,
            ),
            child: const Text(
              'Xác nhận',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
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
            'Xác nhận hoàn thành đơn hàng',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Bạn có muốn tiếp tục?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.themeColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
