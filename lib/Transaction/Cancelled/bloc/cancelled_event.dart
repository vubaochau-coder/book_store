part of 'cancelled_bloc.dart';

abstract class CancelledEvent extends Equatable {
  const CancelledEvent();

  @override
  List<Object> get props => [];
}

class CancelledLoadingEvent extends CancelledEvent {}

class CancelledUpdateEvent extends CancelledEvent {
  final List<TransactionModel> transactions;

  const CancelledUpdateEvent({required this.transactions});
}

class CancelledUpdateEmptyEvent extends CancelledEvent {}
