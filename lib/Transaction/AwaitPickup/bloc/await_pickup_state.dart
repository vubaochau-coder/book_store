part of 'await_pickup_bloc.dart';

abstract class AwaitPickupState extends Equatable {
  const AwaitPickupState();

  @override
  List<Object> get props => [];
}

class AwaitPickupLoadingState extends AwaitPickupState {}

class AwaitPickupLoadingSuccessfulState extends AwaitPickupState {
  final List<TransactionModel> transactions;

  const AwaitPickupLoadingSuccessfulState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class AwaitPickupEmptyState extends AwaitPickupState {}
