part of 'noti_count_bloc.dart';

abstract class NotiCountEvent extends Equatable {
  const NotiCountEvent();

  @override
  List<Object> get props => [];
}

class NotiCountLoadingEvent extends NotiCountEvent {}

class NotiCountUpdateEvent extends NotiCountEvent {
  final int notiCount;

  const NotiCountUpdateEvent({required this.notiCount});

  @override
  List<Object> get props => [notiCount];
}
