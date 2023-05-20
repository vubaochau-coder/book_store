part of 'bill_bloc.dart';

abstract class BillState extends Equatable {
  const BillState();

  @override
  List<Object> get props => [];
}

class BillLoadingState extends BillState {}

class BillLoadingSuccessfulState extends BillState {
  final TransactionModel info;

  const BillLoadingSuccessfulState({required this.info});
}
