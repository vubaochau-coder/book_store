import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/Transaction/AwaitPickup/bloc/await_pickup_bloc.dart';
import 'package:book_store/Transaction/ui/empty_page.dart';
import 'package:book_store/Transaction/AwaitPickup/ui/await_transaction_item.dart';
import 'package:book_store/Transaction/ui/transaction_detail_cancel_page.dart';
import 'package:book_store/Transaction/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwaitPickupTransactionPage extends StatelessWidget {
  const AwaitPickupTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwaitPickupBloc, AwaitPickupState>(
      builder: (context, state) {
        if (state is AwaitPickupEmptyState) {
          return const EmptyTransactionPage();
        } else if (state is AwaitPickupLoadingState) {
          return const TransactionLoadingPage();
        } else if (state is AwaitPickupLoadingSuccessfulState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return AwaitPickupTransactionItem(
                transactionData: state.transactions[index],
                onTap: () {
                  // Navigator.of(context).push(
                  //   PageRouteSlideTransition(
                  //     child: CanCancelledTransactionDetailPage(
                  //       transactionData: state.transactions[index],
                  //       onCancelled: () {},
                  //     ),
                  //   ),
                  // );
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
