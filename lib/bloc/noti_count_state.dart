part of 'noti_count_bloc.dart';

abstract class NotiCountState extends Equatable {
  const NotiCountState();

  @override
  List<Object> get props => [];
}

class NotiCountLoadingState extends NotiCountState {}

class NotiCountLoadingSuccessfulState extends NotiCountState {
  final int notiCount;

  const NotiCountLoadingSuccessfulState({required this.notiCount});

  @override
  List<Object> get props => [notiCount];
}
