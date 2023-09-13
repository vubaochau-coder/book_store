import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:book_store/screens/checkout/ui/checkout_item.dart';
import 'package:book_store/screens/checkout/views/checkout_details.dart';
import 'package:book_store/screens/checkout/views/checkout_terms.dart';
import 'package:book_store/screens/checkout/views/user_note_textfield.dart';
import 'package:book_store/screens/order_bill/ui/order_bill_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/address_selector.dart';
import '../views/bottom_button.dart';
import '../views/loading_layer.dart';
import '../views/payment_method_selector.dart';
import '../views/transport_seletor.dart';

class CheckoutPage extends StatelessWidget {
  final List<CartItemModel> listProduct;
  final bool checkoutFromCart;

  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');

  const CheckoutPage(
      {super.key, required this.listProduct, required this.checkoutFromCart});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      bloc: BlocProvider.of<CheckoutBloc>(context)..add(CheckoutLoadingEvent()),
      listener: (context, state) {
        if (state is CheckoutOrderSuccessfulState) {
          Navigator.of(context).pushAndRemoveUntil(
            PageRouteSlideTransition(
              child: OrderBillPage(
                idTransaction: state.idTransaction,
              ),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return _CheckOutPageContent(listProduct: listProduct);
      },
    );
  }
}

class _CheckOutPageContent extends StatelessWidget {
  final List<CartItemModel> listProduct;
  const _CheckOutPageContent({required this.listProduct});

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(
              'Thanh toán',
              style: AppTexts.appbarTitle,
            ),
            foregroundColor: AppColors.contentColor,
            backgroundColor: AppColors.themeColor,
            elevation: 0,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AddressSelector(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  color: themeColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Sản phẩm',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 12,
                              thickness: 1,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listProduct.length,
                              itemBuilder: (context, index) {
                                return CheckoutItem(data: listProduct[index]);
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  height: 8,
                                  thickness: 1,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const TransportSelector(),
                      UserNoteTextField(textController: noteController),
                      const PaymentMethodSelector(),
                      CheckoutDetails(list: listProduct),
                      const CheckoutTerms(),
                    ],
                  ),
                ),
              ),
              CheckoutBottomButton(list: listProduct),
            ],
          ),
        ),
        const CheckoutLoadingLayer(),
      ],
    );
  }
}
