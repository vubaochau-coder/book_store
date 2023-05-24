part of 'delivered_bloc.dart';

abstract class DeliveredEvent extends Equatable {
  const DeliveredEvent();

  @override
  List<Object> get props => [];
}

class DeliveredLoadingEvent extends DeliveredEvent {}

class DeliveredUpdateEvent extends DeliveredEvent {
  final List<TransactionModel> transactions;

  const DeliveredUpdateEvent({required this.transactions});
}

class DeliveredUpdateEmptyEvent extends DeliveredEvent {}
