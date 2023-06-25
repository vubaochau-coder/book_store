part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationLoadingState extends NotificationState {}

class NotificationEmptyState extends NotificationState {}

class NotificationLoadingSuccessfulState extends NotificationState {
  final List<NotificationModel> notis;
  final String sortType;

  const NotificationLoadingSuccessfulState(
      {required this.notis, required this.sortType});

  @override
  List<Object> get props => [notis, sortType];
}
