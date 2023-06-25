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

class NotificationEmptyEvent extends NotificationEvent {}

class NotificationReadAllEvent extends NotificationEvent {}

class NotificationTappedEvent extends NotificationEvent {
  final String notiID;
  final String actionCode;
  final bool isRead;

  const NotificationTappedEvent(
      {required this.notiID, required this.actionCode, required this.isRead});
}
