import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData leading;
  const CustomListTile({super.key, required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 2,
      shadowColor: themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 52,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Icon(
            leading,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[700],
            size: 18,
          ),
          dense: true,
        ),
      ),
    );
  }
}
