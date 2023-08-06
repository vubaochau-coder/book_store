import 'package:book_store/screens/notification/ui/notification_loading_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class NotificationLoadingPage extends StatelessWidget {
  const NotificationLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> filter = ['Tất cả', 'Chưa đọc', 'Đã đọc'];
    return Column(
      children: [
        SizedBox(
          height: 42,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return filterItem(filter[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 4);
                  },
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'Đọc hết',
                      style: TextStyle(
                        color: themeColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.mark_chat_read_outlined,
                      color: themeColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return const NotificationLoadingItem();
            },
          ),
        ),
      ],
    );
  }

  Widget filterItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
