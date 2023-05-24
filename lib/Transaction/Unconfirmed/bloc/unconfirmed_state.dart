part of 'unconfirmed_bloc.dart';

abstract class UnconfirmedState extends Equatable {
  const UnconfirmedState();

  @override
  List<Object> get props => [];
}

class UnconfirmedLoadingState extends UnconfirmedState {}

class UnconfrimedLoadingSuccessfulState extends UnconfirmedState {
  final List<TransactionModel> transactions;

  const UnconfrimedLoadingSuccessfulState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class UnconfirmedEmptyState extends UnconfirmedState {}
