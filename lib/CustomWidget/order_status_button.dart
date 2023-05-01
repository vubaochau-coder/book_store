import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderStatusButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const OrderStatusButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(
            icon,
            color: themeColor,
            size: 28,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
