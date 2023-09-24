part of 'unconfirmed_bloc.dart';

class UnconfirmedState extends Equatable {
  final bool isLoading;
  final List<TransactionModel> transactions;

  const UnconfirmedState({
    this.isLoading = true,
    this.transactions = const [],
  });

  @override
  List<Object> get props => [isLoading, transactions];

  UnconfirmedState copyWith(
      {bool? isLoading, List<TransactionModel>? transactions}) {
    return UnconfirmedState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }
}
