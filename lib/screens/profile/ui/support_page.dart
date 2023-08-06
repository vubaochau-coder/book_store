import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Thông tin liên hệ'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_outline_rounded,
                color: Color(0xffc71610),
                size: 28,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'chauvodoi001@gmail.com',
                style: TextStyle(
                  color: Color(0xffc71610),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook,
                color: Color(0xff3b5998),
                size: 28,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'https://www.facebook.com/baochau.vbc/',
                style: TextStyle(
                  color: Color(0xff3b5998),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.github,
                color: Color(0xff171515),
                size: 28,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'vubaochau-coder',
                style: TextStyle(
                  color: Color(0xff171515),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
