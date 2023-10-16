import 'package:book_store/custom_widgets/custom_page_route_2.dart';
import 'package:book_store/main.dart';
import 'package:book_store/screens/order_bill/bloc/bill_bloc.dart';
import 'package:book_store/screens/order_bill/ui/order_bill_loading.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBillPage extends StatelessWidget {
  final String idTransaction;
  const OrderBillPage({super.key, required this.idTransaction});

  @override
  Widget build(BuildContext context) {
    double space = 18;
    return BlocBuilder<BillBloc, BillState>(
      bloc: BlocProvider.of<BillBloc>(context)
        ..add(BillLoadingEvent(billID: idTransaction)),
      builder: (context, state) {
        if (state is BillLoadingSuccessfulState) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: kToolbarHeight,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'images/check.png',
                    height: 108,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Đặt hàng thành công',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      '${Converter.convertNumberToMoney(state.info.totalPrice)}đ',
                      style: TextStyle(
                        color: themeColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(
                    width: 304,
                    child: Text(
                      'Cảm ơn vì đã đặt hàng trên IBOO\nBạn có thể theo dõi tình trạng đơn hàng trong mục Đơn hàng của tôi.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 24,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 18),
                      child: Column(
                        children: [
                          Text(
                            'THÔNG TIN ĐƠN HÀNG',
                            style: TextStyle(
                              color: Colors.grey[850],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Mã đơn hàng', style: text1),
                              Text(state.info.id, style: text2),
                            ],
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ngày đặt', style: text1),
                              Text(
                                Converter.convertDateToString(
                                    state.info.dateCreated),
                                style: text2.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ngày giao (dự kiến)', style: text1),
                              Text(
                                Converter.convertDateToStringWithoutTime(
                                    state.info.dateCompleted),
                                style: text2.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Phí vận chuyển', style: text1),
                              Text(
                                '${Converter.convertNumberToMoney(state.info.transportPrice)}đ (${state.info.transport})',
                                style: text2.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Giá sản phẩm', style: text1),
                              Text(
                                '${Converter.convertNumberToMoney(state.info.productPrice)}đ',
                                style:
                                    text2.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng thanh toán', style: text1),
                              Text(
                                '${Converter.convertNumberToMoney(state.info.totalPrice)}đ',
                                style: text2.copyWith(
                                  color: themeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trạng thái', style: text1),
                              Text(
                                state.info.paid
                                    ? 'Đã thanh toán'
                                    : 'Chưa thanh toán',
                                style: text2.copyWith(
                                  color: state.info.paid
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 48,
                    margin:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          PageRouteSlideTransition2(child: const RootPage()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Trở về màn hình chính',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const OrderBillLoading();
        }
      },
    );
  }
}
