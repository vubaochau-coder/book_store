import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/core/models/notification_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notiData;
  const NotificationItem({super.key, required this.notiData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8, top: 4),
            decoration: BoxDecoration(
              color: notiData.isRead ? Colors.grey : AppColors.themeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Image(
              height: 32,
              width: 32,
              image: AssetImage('images/logo_mini.png'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notiData.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color:
                              notiData.isRead ? Colors.black54 : Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      Converter.convertTimeNoti(notiData.date),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    !notiData.isRead
                        ? Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.only(left: 4, top: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeColor,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notiData.content,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 13,
                    color: notiData.isRead ? Colors.black54 : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
