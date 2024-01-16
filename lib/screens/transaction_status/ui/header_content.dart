import 'package:flutter/material.dart';

class HeaderContent extends StatelessWidget {
  final IconData icon;
  final String title;

  const HeaderContent({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
