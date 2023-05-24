part of 'await_pickup_bloc.dart';

abstract class AwaitPickupEvent extends Equatable {
  const AwaitPickupEvent();

  @override
  List<Object> get props => [];
}

class AwaitPickupLoadingEvent extends AwaitPickupEvent {}

class AwaitPickupUpdateEvent extends AwaitPickupEvent {
  final List<TransactionModel> transactions;

  const AwaitPickupUpdateEvent({required this.transactions});
}

class AwaitPicupUpdateEmptyEvent extends AwaitPickupEvent {}
