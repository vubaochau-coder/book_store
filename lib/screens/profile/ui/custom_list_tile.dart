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
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        elevation: 2,
        child: InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            onPressed,
          ),
          child: ListTile(
            horizontalTitleGap: 0,
            leading: Icon(
              leading,
              color: themeColor,
              size: 20,
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 14,
            ),
            dense: true,
          ),
        ),
      ),
    );
  }
}
