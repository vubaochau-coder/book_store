part of 'notification_bloc.dart';

enum SortTypes { all, unRead, read }

class NotificationState extends Equatable {
  final bool isLoading;
  final List<NotificationModel> allNotis;
  final List<NotificationModel> showedNotis;
  final SortTypes sortType;

  const NotificationState({
    this.isLoading = true,
    this.allNotis = const [],
    this.showedNotis = const [],
    this.sortType = SortTypes.all,
  });

  @override
  List<Object> get props => [isLoading, allNotis, sortType, showedNotis];

  NotificationState copyWith({
    bool? isLoading,
    List<NotificationModel>? allNotis,
    List<NotificationModel>? showedNotis,
    SortTypes? sortType,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      allNotis: allNotis ?? this.allNotis,
      showedNotis: showedNotis ?? this.showedNotis,
      sortType: sortType ?? this.sortType,
    );
  }
}
