import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class TinNhanPage extends StatelessWidget {
  const TinNhanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Thông báo'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
                offset: Offset(0, 1),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Phiên bản thử nghiệm',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '04:11 13/06/2023',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Đây là project Đồ án môn học, nên tính năng này chưa thể hoàn thiện. Ngoài ra, nếu bạn gặp vấn đề trong quá trình trải nghiệm, hãy liên hệ với mình qua thông tin trong mục Trợ giúp.',
                style: TextStyle(
                  height: 1.2,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              const Text(
                'IBOO xin chân thành cảm ơn bạn',
                style: TextStyle(
                  height: 1.1,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
