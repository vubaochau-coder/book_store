part of 'cancelled_bloc.dart';

abstract class CancelledState extends Equatable {
  const CancelledState();

  @override
  List<Object> get props => [];
}

class CancelledLoadingState extends CancelledState {}

class CancelledLoadingSuccessfulState extends CancelledState {
  final List<TransactionModel> transactions;

  const CancelledLoadingSuccessfulState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class CancelledEmptyState extends CancelledState {}
