part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingEvent extends CheckoutEvent {}

class CheckoutUpdateAddressEvent extends CheckoutEvent {
  final AddressModel newAddress;
  // final List<TransportModel> transports;

  const CheckoutUpdateAddressEvent({
    required this.newAddress,
    // required this.transports,
  });
}

class CheckoutUpdateTransportEvent extends CheckoutEvent {
  final List<TransportModel> transport;

  const CheckoutUpdateTransportEvent({required this.transport});
}

class CheckoutUpdatePaymentMethodEvent extends CheckoutEvent {
  final List<PaymentMethodModel> payment;

  const CheckoutUpdatePaymentMethodEvent({required this.payment});
}

class CheckoutUpdateEmptyAddressEvent extends CheckoutEvent {
  final List<TransportModel> transports;

  const CheckoutUpdateEmptyAddressEvent({
    required this.transports,
  });
}

class CheckoutSimpleOrderEvent extends CheckoutEvent {
  final TransactionModel transaction;
  final bool fromCart;

  const CheckoutSimpleOrderEvent({
    required this.transaction,
    required this.fromCart,
  });
}

class CheckoutZaloPayOrderEvent extends CheckoutEvent {
  final TransactionModel transaction;
  final bool fromCart;

  const CheckoutZaloPayOrderEvent({
    required this.transaction,
    required this.fromCart,
  });
}
