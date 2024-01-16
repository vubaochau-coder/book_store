import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/cart_item_model.dart';
import '../../../utils/convert.dart';

class CheckoutDetails extends StatelessWidget {
  final List<CartItemModel> list;

  const CheckoutDetails({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state.isLoading || state is CheckoutOrderSuccessfulState) {
          return const SizedBox();
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 18,
                    color: AppColors.themeColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Chi tiết thanh toán',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    'Tổng tiền hàng',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  const Text(
                    'đ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    Converter.convertNumberToMoney(
                      calculateTotalProductPrice(list),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Phí vận chuyển',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  const Text(
                    'đ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    Converter.convertNumberToMoney(
                        state.selectedTransport!.price),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Giảm',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  const Text(
                    'đ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    Converter.convertNumberToMoney(
                      calculateTotalDiscount(list),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Tổng thanh toán',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'đ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.themeColor,
                      decorationColor: AppColors.themeColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    Converter.convertNumberToMoney(
                      calculateTotalProductPrice(list) -
                          calculateTotalDiscount(list) +
                          state.selectedTransport!.price,
                    ),
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  double calculateTotalProductPrice(List<CartItemModel> list) {
    double result = 0;
    for (var item in list) {
      result += item.priceBeforeDiscount * item.count;
    }
    return result;
  }

  double calculateTotalDiscount(List<CartItemModel> list) {
    double result = 0;
    for (var item in list) {
      result += (item.priceBeforeDiscount - item.price) * item.count;
    }
    return result;
  }
}
