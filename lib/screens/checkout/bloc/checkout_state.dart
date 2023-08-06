part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutLoadingSuccessfulState extends CheckoutState {
  final AddressModel userAddress;
  final List<TransportModel> transports;
  final bool showLoadingDialog;
  final List<PaymentMethodModel> payments;

  const CheckoutLoadingSuccessfulState({
    required this.userAddress,
    required this.transports,
    required this.showLoadingDialog,
    required this.payments,
  });

  @override
  List<Object> get props =>
      [userAddress, transports, showLoadingDialog, payments];
}

class CheckoutEmptyAddressState extends CheckoutState {
  final List<TransportModel> transports;
  final List<PaymentMethodModel> payments;
  final bool showLoadingDialog;

  const CheckoutEmptyAddressState({
    required this.transports,
    required this.payments,
    required this.showLoadingDialog,
  });

  @override
  List<Object> get props => [transports, payments, showLoadingDialog];
}

class CheckoutOrderSuccessfulState extends CheckoutState {
  final String idTransaction;

  const CheckoutOrderSuccessfulState({required this.idTransaction});
}
