import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/custom_page_route.dart';
import '../ui/payment_method_page.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading ||
            previous.selectedPayments != current.selectedPayments;
      },
      builder: (context, state) {
        if (state.isLoading || state is CheckoutOrderSuccessfulState) {
          return const SizedBox();
        }

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteSlideTransition(
                child: PaymentMethodListPage(
                  onFinished: (p0) {
                    BlocProvider.of<CheckoutBloc>(context).add(
                      CheckoutUpdatePaymentMethodEvent(payment: p0),
                    );
                    Navigator.of(context).pop();
                  },
                  payments: state.payments,
                  selectedPayment: state.selectedPayments,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 18,
                      color: AppColors.themeColor,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Phương thức thanh toán',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_outlined,
                      size: 20,
                      color: Colors.transparent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      state.selectedPayments!.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    state.selectedPayments!.id == 'zalo'
                        ? Image.asset(
                            state.selectedPayments!.image,
                            height: 18,
                          )
                        : const SizedBox(),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.themeColor,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
