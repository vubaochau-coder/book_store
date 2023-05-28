part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingEvent extends CheckoutEvent {}

class CheckoutUpdateEvent extends CheckoutEvent {
  final AddressModel newAddress;
  final List<TransportModel> transports;

  const CheckoutUpdateEvent({
    required this.newAddress,
    required this.transports,
  });
}

class CheckoutUpdateEmptyAddressEvent extends CheckoutEvent {
  final List<TransportModel> transports;

  const CheckoutUpdateEmptyAddressEvent({
    required this.transports,
  });
}

class CheckoutOrderEvent extends CheckoutEvent {
  final TransactionModel transaction;
  final bool fromCart;

  const CheckoutOrderEvent({
    required this.transaction,
    required this.fromCart,
  });
}
