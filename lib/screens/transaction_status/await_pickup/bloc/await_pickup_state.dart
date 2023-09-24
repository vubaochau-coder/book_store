part of 'await_pickup_bloc.dart';

class AwaitPickupState extends Equatable {
  final bool isLoading;
  final List<TransactionModel> transactions;

  const AwaitPickupState({
    this.isLoading = true,
    this.transactions = const [],
  });

  @override
  List<Object> get props => [isLoading, transactions];

  AwaitPickupState copyWith(
      {bool? isLoading, List<TransactionModel>? transactions}) {
    return AwaitPickupState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }
}
