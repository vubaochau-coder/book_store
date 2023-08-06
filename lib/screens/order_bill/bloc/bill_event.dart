part of 'bill_bloc.dart';

abstract class BillEvent extends Equatable {
  const BillEvent();

  @override
  List<Object> get props => [];
}

class BillLoadingEvent extends BillEvent {
  final String billID;

  const BillLoadingEvent({required this.billID});
}
