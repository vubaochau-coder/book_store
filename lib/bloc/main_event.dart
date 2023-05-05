part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainLoadingEvent extends MainEvent {}

class MainUpdateEvent extends MainEvent {
  final int cartNumber;
  final int messageNumber;

  const MainUpdateEvent(
      {required this.cartNumber, required this.messageNumber});

  @override
  List<Object> get props => [cartNumber, messageNumber];
}
