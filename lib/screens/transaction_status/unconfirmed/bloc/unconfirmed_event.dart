part of 'unconfirmed_bloc.dart';

abstract class UnconfirmedEvent extends Equatable {
  const UnconfirmedEvent();

  @override
  List<Object> get props => [];
}

class UnconfirmedLoadingEvent extends UnconfirmedEvent {}

class UnconfirmedUpdateEvent extends UnconfirmedEvent {
  final List<TransactionModel> transactions;

  const UnconfirmedUpdateEvent({required this.transactions});
}

class UnconfirmedUpdateEmptyEvent extends UnconfirmedEvent {}

class UnconfirmedCancelEvent extends UnconfirmedEvent {
  final String transactionID;

  const UnconfirmedCancelEvent({required this.transactionID});
}
