import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/screens/transaction_status/delivered/bloc/delivered_bloc.dart';
import 'package:book_store/screens/transaction_status/delivered/ui/delivered_transaction_page.dart';
import 'package:book_store/screens/transaction_status/delivering/bloc/delivering_bloc.dart';
import 'package:book_store/screens/transaction_status/delivering/ui/delivering_transaction_page.dart';
import 'package:book_store/screens/transaction_status/unconfirmed/bloc/unconfirmed_bloc.dart';
import 'package:book_store/screens/transaction_status/unconfirmed/ui/unconfirmed_transaction_page.dart';
import 'package:book_store/screens/transaction_status/await_pickup/bloc/await_pickup_bloc.dart';
import 'package:book_store/screens/transaction_status/await_pickup/ui/await_pickup_page.dart';
import 'package:book_store/screens/transaction_status/cancelled/ui/cancelled_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_themes/app_colors.dart';
import '../cancelled/bloc/cancelled_bloc.dart';

class TransactionPage extends StatefulWidget {
  final int currentIndex;
  const TransactionPage({super.key, required this.currentIndex});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: widget.currentIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AwaitPickupBloc()..add(AwaitPickupLoadingEvent()),
        ),
        BlocProvider(
          create: (context) =>
              UnconfirmedBloc()..add(UnconfirmedLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => DeliveringBloc()..add(DeliveringLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => DeliveredBloc()..add(DeliveredLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => CancelledBloc()..add(CancelledLoadingEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Đơn hàng của bạn',
            style: AppTexts.appbarTitle,
          ),
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.contentColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                labelColor: AppColors.themeColor,
                unselectedLabelColor: Colors.grey[400],
                indicator: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.themeColor,
                      width: 2,
                    ),
                  ),
                ),
                tabs: [
                  transactiontab('Chờ xác nhận'),
                  transactiontab('Chờ lấy hàng'),
                  transactiontab('Đang giao'),
                  transactiontab('Đã nhận hàng'),
                  transactiontab('Đã hủy'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  UnconfrimedTransactionPage(),
                  AwaitPickupTransactionPage(),
                  DeliveringTransactionPage(),
                  DeliveredTransactionPage(),
                  CancelledTransactionPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactiontab(String title) {
    return Container(
      height: 36,
      constraints: const BoxConstraints(
        minWidth: 88,
      ),
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
