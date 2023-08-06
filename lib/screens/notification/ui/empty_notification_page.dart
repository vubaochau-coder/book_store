import 'package:flutter/material.dart';

class NotificationEmptyPage extends StatelessWidget {
  const NotificationEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 112,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.6,
                image: AssetImage(
                  'images/bell.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Chưa có thông báo',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
