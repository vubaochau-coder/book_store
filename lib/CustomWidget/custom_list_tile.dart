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
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: 2,
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
                fontSize: 15,
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
      ),
    );
  }
}
