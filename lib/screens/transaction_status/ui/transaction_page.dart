import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/repositories/main_repository.dart';
import '../delivered/bloc/delivered_bloc.dart';
import '../delivered/ui/delivered_transaction_page.dart';
import '../delivering/bloc/delivering_bloc.dart';
import '../delivering/ui/delivering_transaction_page.dart';
import '../unconfirmed/bloc/unconfirmed_bloc.dart';
import '../unconfirmed/ui/unconfirmed_transaction_page.dart';
import '../await_pickup/bloc/await_pickup_bloc.dart';
import '../await_pickup/ui/await_pickup_page.dart';
import '../cancelled/ui/cancelled_transaction_page.dart';
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
          create: (context) => AwaitPickupBloc(
            RepositoryProvider.of<MainRepository>(context).transRepository,
            RepositoryProvider.of<MainRepository>(context).notiRepository,
          )..add(AwaitPickupLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => UnconfirmedBloc(
            RepositoryProvider.of<MainRepository>(context).transRepository,
            RepositoryProvider.of<MainRepository>(context).notiRepository,
          )..add(UnconfirmedLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => DeliveringBloc(
            RepositoryProvider.of<MainRepository>(context).transRepository,
            RepositoryProvider.of<MainRepository>(context).notiRepository,
            RepositoryProvider.of<MainRepository>(context).bookRepository,
            RepositoryProvider.of<MainRepository>(context).feedbackRepository,
          )..add(DeliveringLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => DeliveredBloc(
            RepositoryProvider.of<MainRepository>(context).transRepository,
          )..add(DeliveredLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => CancelledBloc(
            RepositoryProvider.of<MainRepository>(context).transRepository,
          )..add(CancelledLoadingEvent()),
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
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
