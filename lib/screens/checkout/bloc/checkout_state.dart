part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final bool isLoading;
  final bool showLoadingDialog;
  final AddressModel? userAddress;
  final List<TransportModel> transports;
  final TransportModel? selectedTransport;
  final List<PaymentMethodModel> payments;
  final PaymentMethodModel? selectedPayments;
  final String note;

  const CheckoutState({
    this.isLoading = false,
    this.userAddress,
    this.transports = const [],
    this.selectedTransport,
    this.selectedPayments,
    this.showLoadingDialog = false,
    this.payments = const [],
    this.note = '',
  });

  @override
  List<Object?> get props => [
        isLoading,
        userAddress,
        transports,
        showLoadingDialog,
        payments,
        selectedPayments,
        selectedTransport,
        note,
      ];

  CheckoutState copyWith({
    bool? isLoading,
    bool? showLoadingDialog,
    String? note,
    AddressModel? userAddress,
    List<TransportModel>? transports,
    TransportModel? selectedTransport,
    List<PaymentMethodModel>? payments,
    PaymentMethodModel? selectedPayments,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      showLoadingDialog: showLoadingDialog ?? this.showLoadingDialog,
      note: note ?? this.note,
      userAddress: userAddress ?? this.userAddress,
      transports: transports ?? this.transports,
      payments: payments ?? this.payments,
      selectedPayments: selectedPayments ?? this.selectedPayments,
      selectedTransport: selectedTransport ?? this.selectedTransport,
    );
  }
}

class CheckoutOrderSuccessfulState extends CheckoutState {
  final String idTransaction;

  const CheckoutOrderSuccessfulState({required this.idTransaction});
}
