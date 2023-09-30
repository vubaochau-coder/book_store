import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/notification/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotiFilterButton extends StatelessWidget {
  const NotiFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: BlocBuilder<NotificationBloc, NotificationState>(
        buildWhen: (previous, current) {
          return previous.isLoading != current.isLoading ||
              previous.sortType != current.sortType;
        },
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: state.isLoading
                          ? null
                          : () {
                              BlocProvider.of<NotificationBloc>(context).add(
                                NotificationFilterEvent(
                                  filterType: NotiSortTypes.values[index],
                                ),
                              );
                            },
                      child: filterItem(
                        NotiSortTypes.values[index],
                        NotiSortTypes.values[index] == state.sortType,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 4);
                  },
                ),
              ),
              TextButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        BlocProvider.of<NotificationBloc>(context).add(
                          NotificationReadAllEvent(),
                        );
                      },
                child: Row(
                  children: [
                    Text(
                      'Đọc hết',
                      style: TextStyle(
                        color: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.mark_chat_read_outlined,
                      color: AppColors.themeColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String convertNotiSortStype(NotiSortTypes type) {
    switch (type) {
      case NotiSortTypes.all:
        return "Tất cả";
      case NotiSortTypes.read:
        return "Đã đọc";
      case NotiSortTypes.unRead:
        return "Chưa đọc";
    }
  }

  Widget filterItem(NotiSortTypes type, [bool select = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: select ? AppColors.themeColor.withAlpha(50) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: select ? AppColors.themeColor : Colors.grey,
        ),
      ),
      child: Text(
        convertNotiSortStype(type),
        style: TextStyle(
          color: select ? AppColors.themeColor : Colors.grey,
          fontWeight: select ? FontWeight.w600 : FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}
