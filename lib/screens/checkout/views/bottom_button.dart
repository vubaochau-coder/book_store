import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/address_model.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/transport_model.dart';
import '../../../utils/convert.dart';

class CheckoutBottomButton extends StatelessWidget {
  final List<CartItemModel> list;
  final bool fromCart;

  const CheckoutBottomButton({
    super.key,
    required this.list,
    required this.fromCart,
  });

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

        return SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tổng thanh toán',
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
                              calculateTotalProductPrice(list) -
                                  calculateTotalDiscount(list) +
                                  state.selectedTransport!.price,
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
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.selectedPayments!.id == 'zalo') {
                        BlocProvider.of<CheckoutBloc>(context).add(
                          CheckoutZaloPayOrderEvent(
                            // transaction: TransactionModel(
                            //   id: '',
                            //   dateCreated: DateTime.now(),
                            //   dateCompleted:
                            //       getDateCompleted(state.selectedTransport),
                            //   address: getDefaultAddress(state.userAddress),
                            //   transport: state.selectedTransport!.name,
                            //   note: state.note,
                            //   totalPrice: calculateTotalPrice(
                            //       list, state.selectedTransport!),
                            //   productPrice: calculateTotalProductPrice(list) -
                            //       calculateTotalDiscount(list),
                            //   transportPrice: state.selectedTransport!.price,
                            //   products: list,
                            //   status: 0,
                            //   paid: true,
                            //   paymentMethod: 'ZaloPay',
                            // ),
                            list: list,
                            fromCart: fromCart,
                          ),
                        );
                      } else {
                        BlocProvider.of<CheckoutBloc>(context).add(
                          CheckoutSimpleOrderEvent(
                            // transaction: TransactionModel(
                            //   id: '',
                            //   dateCreated: DateTime.now(),
                            //   dateCompleted:
                            //       getDateCompleted(state.selectedTransport),
                            //   address: getDefaultAddress(state.userAddress),
                            //   transport: state.selectedTransport!.name,
                            //   note: state.note,
                            //   totalPrice: calculateTotalPrice(
                            //       list, state.selectedTransport!),
                            //   productPrice: calculateTotalProductPrice(list) -
                            //       calculateTotalDiscount(list),
                            //   transportPrice: state.selectedTransport!.price,
                            //   products: list,
                            //   status: 0,
                            //   paid: false,
                            //   paymentMethod: 'Thanh toán khi nhận hàng',
                            //   phone: state.userAddress!.phone,
                            //   userName: state.userAddress!.name,
                            // ),
                            list: list,
                            fromCart: fromCart,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Đặt hàng',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getDefaultAddress(AddressModel? address) {
    String result = '';
    if (address == null) {
      result = 'Bạn chưa có địa chỉ giao hàng mặc định, vui lòng cập nhật ngay';
    } else {
      result = '${address.name} | ${address.phone}\n${address.address}';
    }
    return result;
  }

  DateTime getDateCompleted(TransportModel? transportModel) {
    final dateNow = DateTime.now();
    final dayFromNow = dateNow.add(Duration(days: transportModel!.max));
    return dayFromNow;
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
