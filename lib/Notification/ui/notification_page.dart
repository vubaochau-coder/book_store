import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/Notification/ui/empty_notification_page.dart';
import 'package:book_store/Notification/ui/notification_item.dart';
import 'package:book_store/Notification/ui/notification_loading_page.dart';
import 'package:book_store/Transaction/ui/transaction_page.dart';
import 'package:book_store/models/notification_model.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notification_bloc.dart';

class TinNhanPage extends StatelessWidget {
  const TinNhanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Thông báo'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return const NotificationLoadingPage();
          } else if (state is NotificationLoadingSuccessfulState) {
            return buildNotificationPage(context, state.notis, state.sortType);
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }

  Widget buildNotificationPage(
      BuildContext context, List<NotificationModel> notis, String sortType) {
    int indexSelected = 0;
    List<String> filter = ['Tất cả', 'Chưa đọc', 'Đã đọc'];
    List<String> filterCode = ['all', 'unread', 'read'];
    switch (sortType) {
      case 'all':
        indexSelected = 0;
        break;
      case 'unread':
        indexSelected = 1;
        break;
      case 'read':
        indexSelected = 2;
        break;
    }
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
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<NotificationBloc>(context).add(
                          NotificationFilterEvent(
                              filterType: filterCode[index]),
                        );
                      },
                      child: filterItem(filter[index], index == indexSelected),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 4);
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<NotificationBloc>(context)
                      .add(NotificationReadAllEvent());
                },
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
          child: notis.isEmpty
              ? const NotificationEmptyPage()
              : ListView.builder(
                  itemCount: notis.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (notis[index].isRead == false) {
                          BlocProvider.of<NotificationBloc>(context).add(
                              NotificationTappedEvent(notiID: notis[index].id));
                        }
                        int pageIndex = 0;
                        switch (notis[index].actionCode) {
                          case 'order_0':
                            pageIndex = 0;
                            break;
                          case 'order_-1':
                            pageIndex = 4;
                            break;
                          case 'order_3':
                            pageIndex = 3;
                            break;
                        }
                        Navigator.of(context).push(PageRouteSlideTransition(
                            child: TransactionPage(currentIndex: pageIndex)));
                      },
                      child: NotificationItem(notiData: notis[index]),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget filterItem(String text, bool select) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: select ? themeColor.withAlpha(50) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: select ? themeColor : Colors.grey,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: select ? themeColor : Colors.grey,
          fontWeight: select ? FontWeight.w500 : FontWeight.w400,
        ),
      ),
    );
  }
}
