part of 'delivering_bloc.dart';

class DeliveringState extends Equatable {
  final bool isLoading;
  final List<TransactionModel> transactions;

  const DeliveringState({
    this.isLoading = true,
    this.transactions = const [],
  });

  @override
  List<Object> get props => [isLoading, transactions];

  DeliveringState copyWith({
    bool? isLoading,
    List<TransactionModel>? transactions,
  }) {
    return DeliveringState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }
}
