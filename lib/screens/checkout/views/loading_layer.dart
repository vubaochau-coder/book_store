import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CheckoutLoadingLayer extends StatelessWidget {
  const CheckoutLoadingLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) {
        return previous.showLoadingDialog != current.showLoadingDialog;
      },
      builder: (context, state) {
        if (state.showLoadingDialog) {
          return Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 80,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Material(
                  color: Colors.transparent,
                  child: Text(
                    'Đang xử lý đơn hàng',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
