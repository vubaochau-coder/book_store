part of 'delivering_bloc.dart';

abstract class DeliveringState extends Equatable {
  const DeliveringState();

  @override
  List<Object> get props => [];
}

class DeliveringLoadingState extends DeliveringState {}

class DeliveringLoadingSuccessfulState extends DeliveringState {
  final List<TransactionModel> transactions;

  const DeliveringLoadingSuccessfulState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class DeliveringEmptyState extends DeliveringState {}
