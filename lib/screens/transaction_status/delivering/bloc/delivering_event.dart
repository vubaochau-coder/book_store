part of 'delivering_bloc.dart';

abstract class DeliveringEvent extends Equatable {
  const DeliveringEvent();

  @override
  List<Object> get props => [];
}

class DeliveringLoadingEvent extends DeliveringEvent {}

class DeliveringUpdateEvent extends DeliveringEvent {
  final List<TransactionModel> transactions;

  const DeliveringUpdateEvent({required this.transactions});
}

class DeliveringUpdateEmptyEvent extends DeliveringEvent {}

class DeliveringReceiveEvent extends DeliveringEvent {
  final String transactionID;

  const DeliveringReceiveEvent({required this.transactionID});
}
