part of 'delivered_bloc.dart';

abstract class DeliveredState extends Equatable {
  const DeliveredState();

  @override
  List<Object> get props => [];
}

class DeliveredLoadingState extends DeliveredState {}

class DeliveredLoadingSuccessfulState extends DeliveredState {
  final List<TransactionModel> transactions;

  const DeliveredLoadingSuccessfulState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class DeliveredEmptyState extends DeliveredState {}
