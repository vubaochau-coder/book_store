import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/custom_page_route.dart';
import '../../../models/cart_item_model.dart';
import '../../../utils/convert.dart';
import '../../checkout/ui/checkout_page.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        return previous.selectedCartitems != current.selectedCartitems;
      },
      builder: (context, state) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thành tiền',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'đ',
                        style: TextStyle(
                          color: AppColors.themeColor,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(
                          calculateTotalPrice(state.selectedCartitems),
                        ),
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: state.selectedCartitems.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: CheckoutPage(
                                listProduct: state.selectedCartitems,
                                checkoutFromCart: true,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    backgroundColor: AppColors.themeColor,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Thanh toán',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double calculateTotalPrice(List<CartItemModel> list) {
    double result = 0;
    for (var item in list) {
      result += item.price * item.count;
    }
    return result;
  }
}
