import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  static TextStyle textStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Thông tin liên hệ',
          style: AppTexts.appbarTitle,
        ),
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.contentColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          contentItem(
            Icons.mail_outline_rounded,
            'chauvodoi001@gmail.com',
            const Color(0xffc71610),
          ),
          contentItem(
            Icons.facebook,
            'https://www.facebook.com/baochau.vbc/',
            const Color(0xff3b5998),
          ),
          contentItem(
            FontAwesomeIcons.github,
            'vubaochau-coder',
            const Color(0xff171515),
          ),
        ],
      ),
    );
  }

  Widget contentItem(IconData icon, String content, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            content,
            style: textStyle.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
