import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final Function() onPressed;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.leading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 52,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Icon(
            leading,
            color: themeColor,
            size: 20,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[700],
            size: 14,
          ),
          dense: true,
        ),
      ),
    );
  }
}
