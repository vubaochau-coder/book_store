import 'package:book_store/Checkout/bloc/checkout_bloc.dart';
import 'package:book_store/AddressSetting/ui/address_setting.dart';
import 'package:book_store/Checkout/ui/checkout_item.dart';
import 'package:book_store/Checkout/ui/checkout_loading.dart';
import 'package:book_store/Checkout/ui/payment_method_page.dart';
import 'package:book_store/Checkout/ui/transport_page.dart';
import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/OrderBill/ui/order_bill_page.dart';
import 'package:book_store/models/address_model.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/payment_method_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:book_store/models/transport_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CheckoutPage extends StatelessWidget {
  final List<CartItemModel> listProduct;
  final bool checkoutFromCart;

  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');

  const CheckoutPage(
      {super.key, required this.listProduct, required this.checkoutFromCart});

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
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
              (route) => false);
        }
      },
      builder: (context, state) {
        if (state is CheckoutLoadingState) {
          return CheckoutLoading(listProduct: listProduct);
        } else if (state is CheckoutLoadingSuccessfulState) {
          return checkoutSuccess(
              context,
              listProduct,
              state.userAddress,
              state.transports,
              state.payments,
              noteController,
              state.showLoadingDialog);
        } else if (state is CheckoutEmptyAddressState) {
          return checkoutSuccess(
              context,
              listProduct,
              const AddressModel(
                  id: '', name: '', phone: '', address: '', isDefault: false),
              state.transports,
              state.payments,
              noteController,
              false);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget checkoutSuccess(
    BuildContext context,
    List<CartItemModel> list,
    AddressModel address,
    List<TransportModel> listTrans,
    List<PaymentMethodModel> listPayment,
    TextEditingController noteController,
    bool showLoadingDialog,
  ) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: const Text('Thanh toán'),
            foregroundColor: Colors.white,
            backgroundColor: themeColor,
            elevation: 0,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: const AddressSettingPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          margin: const EdgeInsets.only(top: 4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.pin_drop_outlined,
                                          color: themeColor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text(
                                          'Địa chỉ giao hàng',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.pin_drop_outlined,
                                          color: Colors.transparent,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            getDefaultAddress(address),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Sản phẩm',
                                  style: TextStyle(
                                    fontSize: 16,
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
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return CheckoutItem(data: list[index]);
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 246, 255, 254),
                          border: Border(
                            top: BorderSide(
                              color: Color.fromARGB(255, 198, 221, 218),
                            ),
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 198, 221, 218),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining_outlined,
                                  size: 20,
                                  color: themeColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Phương thức vận chuyển',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteSlideTransition(
                                    child: TransportListPage(
                                      onFinished: (p0) {
                                        BlocProvider.of<CheckoutBloc>(context)
                                            .add(
                                          CheckoutUpdateTransportEvent(
                                            transport: p0,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      transports: listTrans,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      getTransportMethod(listTrans).name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'đ',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Text(
                                    Converter.convertNumberToMoney(
                                        getTransportMethod(listTrans).price),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              getTransportDescription(
                                  getTransportMethod(listTrans)),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Text('Tin nhắn:'),
                            Expanded(
                              child: TextField(
                                controller: noteController,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Tin nhắn cho người bán...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: PaymentMethodListPage(
                                onFinished: (p0) {
                                  BlocProvider.of<CheckoutBloc>(context).add(
                                    CheckoutUpdatePaymentMethodEvent(
                                      payment: p0,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                payments: listPayment,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          margin: const EdgeInsets.only(top: 4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_outlined,
                                    size: 20,
                                    color: themeColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    'Phương thức thanh toán',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    size: 20,
                                    color: Colors.transparent,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    getPaymentMethod(listPayment).name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: themeColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  getPaymentMethod(listPayment).id == 'zalo'
                                      ? Image.asset(
                                          getPaymentMethod(listPayment).image,
                                          height: 20,
                                        )
                                      : const SizedBox(),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: themeColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
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
                                  size: 20,
                                  color: themeColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Chi tiết thanh toán',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Tổng tiền hàng',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'đ',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  Converter.convertNumberToMoney(
                                    calculateTotalProductPrice(list),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Phí vận chuyển',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'đ',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  Converter.convertNumberToMoney(
                                      getTransportPrice(listTrans)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Giảm',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'đ',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  Converter.convertNumberToMoney(
                                      calculateTotalDiscount(list)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Tổng thanh toán',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'đ',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: themeColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  Converter.convertNumberToMoney(
                                      calculateTotalPrice(list, listTrans)),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: themeColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        margin: const EdgeInsets.only(top: 4, bottom: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.library_books_outlined,
                              size: 20,
                              color: themeColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Nhấn "Đặt hàng" đồng nghĩa với việc bạn đồng ý tuân theo ',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Điều khoản IBOO.',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        color: Colors.white,
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
                                    color: themeColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  Converter.convertNumberToMoney(
                                      calculateTotalPrice(list, listTrans)),
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
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (getPaymentMethod(listPayment).id == 'zalo') {
                              BlocProvider.of<CheckoutBloc>(context).add(
                                CheckoutZaloPayOrderEvent(
                                    transaction: TransactionModel(
                                      id: '',
                                      dateCreated: DateTime.now(),
                                      dateCompleted: getDateCompleted(
                                          getTransportMethod(listTrans)),
                                      address: getDefaultAddress(address),
                                      transport:
                                          getTransportMethod(listTrans).name,
                                      note: noteController.text.trim(),
                                      totalPrice:
                                          calculateTotalPrice(list, listTrans),
                                      productPrice:
                                          calculateTotalProductPrice(list) -
                                              calculateTotalDiscount(list),
                                      transportPrice:
                                          getTransportMethod(listTrans).price,
                                      products: list,
                                      status: 0,
                                      paid: true,
                                      paymentMethod: 'ZaloPay',
                                    ),
                                    fromCart: checkoutFromCart),
                              );
                            } else {
                              BlocProvider.of<CheckoutBloc>(context).add(
                                CheckoutSimpleOrderEvent(
                                  transaction: TransactionModel(
                                    id: '',
                                    dateCreated: DateTime.now(),
                                    dateCompleted: getDateCompleted(
                                        getTransportMethod(listTrans)),
                                    address: getDefaultAddress(address),
                                    transport:
                                        getTransportMethod(listTrans).name,
                                    note: noteController.text.trim(),
                                    totalPrice:
                                        calculateTotalPrice(list, listTrans),
                                    productPrice:
                                        calculateTotalProductPrice(list) -
                                            calculateTotalDiscount(list),
                                    transportPrice:
                                        getTransportMethod(listTrans).price,
                                    products: list,
                                    status: 0,
                                    paid: false,
                                    paymentMethod: 'Thanh toán khi nhận hàng',
                                  ),
                                  fromCart: checkoutFromCart,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
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
              ),
            ],
          ),
        ),
        showLoadingDialog ? progressDialogue(context) : const SizedBox(),
      ],
    );
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

  double getTransportPrice(List<TransportModel> transports) {
    double result = 0;
    for (var item in transports) {
      if (item.isSelected) {
        return item.price;
      }
    }
    return result;
  }

  String getTransportDescription(TransportModel transport) {
    return 'Nhận hàng sau ${transport.min}-${transport.max} ngày';
  }

  double calculateTotalPrice(
      List<CartItemModel> list, List<TransportModel> transports) {
    double result = 0;
    for (var item in list) {
      result += item.price * item.count;
    }

    for (var item in transports) {
      if (item.isSelected) {
        result += item.price;
      }
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

  TransportModel getTransportMethod(List<TransportModel> transports) {
    for (var ele in transports) {
      if (ele.isSelected) {
        return ele;
      }
    }
    return transports[0];
  }

  PaymentMethodModel getPaymentMethod(List<PaymentMethodModel> payments) {
    for (var ele in payments) {
      if (ele.isSelected) {
        return ele;
      }
    }
    return payments[0];
  }

  String getDefaultAddress(AddressModel address) {
    String result = '';
    if (address.id == '') {
      result = 'Bạn chưa có địa chỉ giao hàng mặc định, vui lòng cập nhật ngay';
    } else {
      result = '${address.name} | ${address.phone}\n${address.address}';
    }
    return result;
  }

  Widget progressDialogue(BuildContext context) {
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
}
