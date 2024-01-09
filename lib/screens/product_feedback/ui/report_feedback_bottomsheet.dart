import 'package:book_store/app_themes/app_colors.dart';
import 'package:flutter/material.dart';

class ReportFeedbackBottomSheet extends StatefulWidget {
  const ReportFeedbackBottomSheet({super.key});

  @override
  State<ReportFeedbackBottomSheet> createState() =>
      _ReportFeedbackBottomSheetState();
}

class _ReportFeedbackBottomSheetState extends State<ReportFeedbackBottomSheet> {
  int _selectIndex = -1;

  final List<String> reportType = [
    'Đánh giá thô tục phản cảm',
    'Chứa thông tin cá nhân',
    'Quảng cáo trái phép',
    'Đánh giá trùng lặp (thông tin rác)',
    'Đánh giá không chính xác / gây hiểu lầm (ví dụ: đánh giá sản phẩm không khớp,..)',
    'Khác',
  ];

  final List<String> reportTypeFinal = [
    'Đánh giá thô tục phản cảm',
    'Chứa thông tin cá nhân',
    'Quảng cáo trái phép',
    'Đánh giá trùng lặp',
    'Đánh giá không chính xác / gây hiểu lầm',
    'Khác',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              'Báo cáo bình luận',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lí do báo cáo',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            itemCount: reportType.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return tile(reportType[index], index, _selectIndex);
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_selectIndex != -1) {
                  Navigator.of(context).pop(reportTypeFinal[_selectIndex]);
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:
                    _selectIndex != -1 ? AppColors.themeColor : Colors.grey,
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text(
                'Gửi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tile(String title, value, selectedValue) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectIndex = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(title),
            ),
            Icon(
              Icons.check,
              color: selectedValue == value
                  ? AppColors.themeColor
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
