part of 'delivered_bloc.dart';

class DeliveredState extends Equatable {
  final bool isLoading;
  final List<TransactionModel> transactions;

  const DeliveredState({
    this.isLoading = true,
    this.transactions = const [],
  });

  @override
  List<Object> get props => [isLoading, transactions];

  DeliveredState copyWith({
    bool? isLoading,
    List<TransactionModel>? transactions,
  }) {
    return DeliveredState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }
}
