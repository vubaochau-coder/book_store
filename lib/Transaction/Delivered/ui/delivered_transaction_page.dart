import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/Transaction/Delivered/bloc/delivered_bloc.dart';
import 'package:book_store/Transaction/Delivered/ui/delivered_item.dart';
import 'package:book_store/Transaction/ui/empty_page.dart';
import 'package:book_store/Transaction/ui/transaction_detail_reorder_page.dart';
import 'package:book_store/Transaction/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveredTransactionPage extends StatelessWidget {
  const DeliveredTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveredBloc, DeliveredState>(
      builder: (context, state) {
        if (state is DeliveredEmptyState) {
          return const EmptyTransactionPage();
        } else if (state is DeliveredLoadingState) {
          return const TransactionLoadingPage();
        } else if (state is DeliveredLoadingSuccessfulState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return DeliveredItem(
                transactionData: state.transactions[index],
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteSlideTransition(
                      child: ReOrderTransactionDetailPage(
                        transactionData: state.transactions[index],
                        onReOrder: () {},
                      ),
                    ),
                  );
                },
                onReOrder: () {},
              );
            },
            itemCount: state.transactions.length,
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
