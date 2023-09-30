part of 'notification_bloc.dart';

enum NotiSortTypes { all, unRead, read }

class NotificationState extends Equatable {
  final bool isLoading;
  final List<NotificationModel> allNotis;
  final List<NotificationModel> showedNotis;
  final NotiSortTypes sortType;

  const NotificationState({
    this.isLoading = true,
    this.allNotis = const [],
    this.showedNotis = const [],
    this.sortType = NotiSortTypes.all,
  });

  @override
  List<Object> get props => [isLoading, allNotis, sortType, showedNotis];

  NotificationState copyWith({
    bool? isLoading,
    List<NotificationModel>? allNotis,
    List<NotificationModel>? showedNotis,
    NotiSortTypes? sortType,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      allNotis: allNotis ?? this.allNotis,
      showedNotis: showedNotis ?? this.showedNotis,
      sortType: sortType ?? this.sortType,
    );
  }
}
