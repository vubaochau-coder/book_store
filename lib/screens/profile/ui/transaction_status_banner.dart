import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/screens/my_feedback/ui/my_feedback_page.dart';
import 'package:book_store/screens/profile/bloc/feedback_count_bloc.dart';
import 'package:book_store/screens/profile/bloc/user_bloc.dart';
import 'package:book_store/screens/profile/ui/transaction_status_button.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionStatusBanner extends StatelessWidget {
  const TransactionStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      margin: const EdgeInsets.only(top: 18, bottom: 18),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Đơn hàng của tôi',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const OrderStatusButton(
                          text: 'Chờ xác nhận',
                          icon: FontAwesomeIcons.envelopeOpenText,
                          badgeCount: 0,
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          navigateToTransactionPage(0, context);
                        },
                        child: OrderStatusButton(
                          text: 'Chờ xác nhận',
                          icon: FontAwesomeIcons.envelopeOpenText,
                          badgeCount: state.zero,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const OrderStatusButton(
                          text: 'Chờ lấy hàng',
                          icon: FontAwesomeIcons.box,
                          badgeCount: 0,
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          navigateToTransactionPage(1, context);
                        },
                        child: OrderStatusButton(
                          text: 'Chờ lấy hàng',
                          icon: FontAwesomeIcons.box,
                          badgeCount: state.one,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const OrderStatusButton(
                          text: 'Đang giao',
                          icon: FontAwesomeIcons.truckFast,
                          badgeCount: 0,
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          navigateToTransactionPage(2, context);
                        },
                        child: OrderStatusButton(
                          text: 'Đang giao',
                          icon: FontAwesomeIcons.truckFast,
                          badgeCount: state.two,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<FeedbackCountBloc, FeedbackCountState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const OrderStatusButton(
                          text: 'Đánh giá',
                          icon: FontAwesomeIcons.star,
                          badgeCount: 0,
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: const MyFeedbackPage(),
                            ),
                          );
                        },
                        child: OrderStatusButton(
                          text: 'Đánh giá',
                          icon: FontAwesomeIcons.star,
                          badgeCount: state.totalFeedback,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToTransactionPage(int index, BuildContext context) {
    Navigator.of(context).push(
      PageRouteSlideTransition(
        child: TransactionPage(currentIndex: index),
      ),
    );
  }
}
