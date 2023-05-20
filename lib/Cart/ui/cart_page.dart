import 'package:book_store/Cart/bloc/cart_bloc.dart';
import 'package:book_store/Cart/ui/cart_loading_page.dart';
import 'package:book_store/Checkout/ui/checkout_page.dart';
import 'package:book_store/Cart/ui/cart_item.dart';
import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GioHangPage extends StatelessWidget {
  const GioHangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        title: const Text('Giỏ hàng'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        //bloc: BlocProvider.of<CartBloc>(context)..add(CartLoadingEvent()),
        builder: (context, state) {
          if (state is CartLoadingSuccessfulState) {
            return buildListProduct(context, state.cartItems);
          } else if (state is CartLoadingState) {
            return const CartLoadingPage();
          } else if (state is CartEmptyState) {
            return buildListProduct(context, []);
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  Widget buildListProduct(BuildContext context, List<CartItemModel> listCart) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                elevation: 1,
                child: Row(
                  children: [
                    Checkbox(
                      value: isAllItemSelected(listCart),
                      onChanged: (value) {
                        BlocProvider.of<CartBloc>(context)
                            .add(CartAllItemSelectedEvent(listCart: listCart));
                      },
                    ),
                    Text(
                      'Chọn tất cả (${listCart.length} sản phẩm)',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CartItem(
                      cartData: listCart[index],
                      onDecrease: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartChangeItemQuantityEvent(
                              itemID: listCart[index].id,
                              isIncrease: false,
                              listCart: listCart),
                        );
                      },
                      onIncrease: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartChangeItemQuantityEvent(
                              itemID: listCart[index].id,
                              isIncrease: true,
                              listCart: listCart),
                        );
                      },
                      onRemove: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartRemoveItemEvent(itemID: listCart[index].id),
                        );
                      },
                      onSelected: (bool? value) {
                        BlocProvider.of<CartBloc>(context).add(
                          CartItemSelectedEvent(
                              itemID: listCart[index].id, listCart: listCart),
                        );
                      },
                    );
                  },
                  itemCount: listCart.length,
                ),
              ),
            ],
          ),
        ),
        Container(
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
                          color: themeColor,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(
                            calculateTotalPrice(listCart)),
                        style: TextStyle(
                          color: themeColor,
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
                  onPressed: () {
                    if (!isNoItemSelected(listCart)) {
                      Navigator.of(context).push(
                        PageRouteSlideTransition(
                          child: CheckoutPage(
                            listProduct: selectedList(listCart),
                            checkoutFromCart: true,
                          ),
                        ),
                      );
                    } else {
                      showErorrToast(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    backgroundColor: themeColor,
                  ),
                  child: Row(
                    children: const [
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
        ),
      ],
    );
  }

  double calculateTotalPrice(List<CartItemModel> list) {
    double result = 0;
    for (var item in list) {
      if (item.isSelected) {
        result += item.price * item.count;
      }
    }
    return result;
  }

  bool isAllItemSelected(List<CartItemModel> list) {
    for (var ele in list) {
      if (ele.isSelected == false) {
        return false;
      }
    }
    return true;
  }

  bool isNoItemSelected(List<CartItemModel> list) {
    for (var ele in list) {
      if (ele.isSelected) {
        return false;
      }
    }
    return true;
  }

  List<CartItemModel> selectedList(List<CartItemModel> list) {
    List<CartItemModel> result = [];
    for (var item in list) {
      if (item.isSelected) {
        result.add(item);
      }
    }
    return result;
  }

  void showErorrToast(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff323232),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Bạn vẫn chưa chọn sản phẩm nào để mua.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.CENTER,
    );
  }
}
