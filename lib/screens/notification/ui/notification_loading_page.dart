import 'package:book_store/screens/notification/ui/notification_loading_item.dart';
import 'package:flutter/material.dart';

class NotificationLoadingPage extends StatelessWidget {
  const NotificationLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return const NotificationLoadingItem();
      },
    );
  }
}
