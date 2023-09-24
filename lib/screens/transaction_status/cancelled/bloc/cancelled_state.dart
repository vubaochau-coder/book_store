part of 'cancelled_bloc.dart';

class CancelledState extends Equatable {
  final bool isLoading;
  final List<TransactionModel> transactions;

  const CancelledState({
    this.isLoading = true,
    this.transactions = const [],
  });

  @override
  List<Object> get props => [isLoading, transactions];

  CancelledState copyWith({
    bool? isLoading,
    List<TransactionModel>? transactions,
  }) {
    return CancelledState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }
}
