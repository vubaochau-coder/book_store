part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationLoadingEvent extends NotificationEvent {}

class NotificationUpdateEvent extends NotificationEvent {
  final List<NotificationModel> newNotis;

  const NotificationUpdateEvent({required this.newNotis});
}

class NotificationFilterEvent extends NotificationEvent {
  final NotiSortTypes filterType;

  const NotificationFilterEvent({required this.filterType});
}

class NotificationReadAllEvent extends NotificationEvent {}

class NotificationTappedEvent extends NotificationEvent {
  final String notiID;

  const NotificationTappedEvent({required this.notiID});
}
