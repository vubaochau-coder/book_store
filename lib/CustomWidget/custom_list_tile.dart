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
      splashColor: themeColor.withAlpha(100),
      onTap: onPressed,
      child: Container(
        //height: 52,
        margin: const EdgeInsets.only(top: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            colors: [
              themeColor,
              Colors.white,
            ],
            stops: const [0.01, 0.01],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
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
              fontSize: 15,
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
    );
  }
}
