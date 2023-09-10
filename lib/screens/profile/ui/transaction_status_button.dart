import 'package:badges/badges.dart' as badge;
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderStatusButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final int badgeCount;
  const OrderStatusButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          badge.Badge(
            showBadge: badgeCount > 0,
            badgeContent: Text(
              badgeCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            badgeStyle: const badge.BadgeStyle(
              padding: EdgeInsets.all(4),
            ),
            child: FaIcon(
              icon,
              color: themeColor.withAlpha(250),
              size: 28,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          )
        ],
      ),
    );
  }
}
