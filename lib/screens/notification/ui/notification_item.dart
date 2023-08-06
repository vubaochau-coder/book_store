import 'package:book_store/models/notification_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notiData;
  const NotificationItem({super.key, required this.notiData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: notiData.isRead
            ? []
            : [
                const BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey,
                  offset: Offset(0, 1),
                )
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !notiData.isRead
                  ? Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(right: 6, top: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeColor,
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: Text(
                  notiData.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: notiData.isRead ? Colors.black54 : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            color: Colors.white,
            child: Text(
              Converter.convertDateToString(notiData.date),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            notiData.content,
            style: TextStyle(
              height: 1.4,
              color: notiData.isRead ? Colors.black54 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
