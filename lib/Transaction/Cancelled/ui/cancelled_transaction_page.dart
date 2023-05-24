import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/Transaction/Cancelled/bloc/cancelled_bloc.dart';
import 'package:book_store/Transaction/Cancelled/ui/cancelled_item.dart';
import 'package:book_store/Transaction/ui/empty_page.dart';
import 'package:book_store/Transaction/ui/transaction_detail_reorder_page.dart';
import 'package:book_store/Transaction/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledTransactionPage extends StatelessWidget {
  const CancelledTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelledBloc, CancelledState>(
      builder: (context, state) {
        if (state is CancelledEmptyState) {
          return const EmptyTransactionPage();
        } else if (state is CancelledLoadingState) {
          return const TransactionLoadingPage();
        } else if (state is CancelledLoadingSuccessfulState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return CancelledItem(
                transactionData: state.transactions[index],
                onReOrder: () {},
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
