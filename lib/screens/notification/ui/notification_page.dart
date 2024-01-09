import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/screens/notification/ui/empty_notification_page.dart';
import 'package:book_store/screens/notification/ui/filter_button.dart';
import 'package:book_store/screens/notification/ui/notification_item.dart';
import 'package:book_store/screens/notification/ui/notification_loading_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: AppTexts.appbarTitle,
        ),
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.contentColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const NotiFilterButton(),
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              buildWhen: (previous, current) {
                return previous.isLoading != current.isLoading ||
                    previous.showedNotis != current.showedNotis;
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return const NotificationLoadingPage();
                }

                if (state.showedNotis.isEmpty) {
                  return const NotificationEmptyPage();
                }

                return ListView.builder(
                  itemCount: state.showedNotis.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (state.showedNotis[index].isRead == false) {
                          BlocProvider.of<NotificationBloc>(context).add(
                            NotificationTappedEvent(
                                notiID: state.showedNotis[index].id),
                          );
                        }
                        int pageIndex = -1;
                        switch (state.showedNotis[index].actionCode) {
                          case 'order_0':
                            pageIndex = 0;
                            break;
                          case 'order_1':
                            pageIndex = 1;
                            break;
                          case 'order_2':
                            pageIndex = 2;
                            break;
                          case 'order_3':
                            pageIndex = 3;
                            break;
                          case 'order_-1':
                            pageIndex = 4;
                            break;
                          default:
                            pageIndex = -1;
                            break;
                        }
                        if (pageIndex != -1) {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: TransactionPage(currentIndex: pageIndex),
                            ),
                          );
                        }
                      },
                      child: NotificationItem(
                        notiData: state.showedNotis[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
