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

  const CheckoutLoadingSuccessfulState({
    required this.userAddress,
    required this.transports,
    required this.showLoadingDialog,
  });

  @override
  List<Object> get props => [userAddress, transports, showLoadingDialog];
}

class CheckoutEmptyAddressState extends CheckoutState {
  final List<TransportModel> transports;

  const CheckoutEmptyAddressState({required this.transports});
}

class CheckoutOrderSuccessfulState extends CheckoutState {
  final String idTransaction;

  const CheckoutOrderSuccessfulState({required this.idTransaction});
}
