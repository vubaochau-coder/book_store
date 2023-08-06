import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/screens/transaction_status/await_pickup/bloc/await_pickup_bloc.dart';
import 'package:book_store/screens/transaction_status/await_pickup/ui/await_transaction_item.dart';
import 'package:book_store/screens/transaction_status/ui/confirm_cancelled_dialog.dart';
import 'package:book_store/screens/transaction_status/ui/empty_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_detail_cancel_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_loading.dart';
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
                  Navigator.of(context).push(
                    PageRouteSlideTransition(
                      child: CanCancelledTransactionDetailPage(
                        transactionData: state.transactions[index],
                        onCancelled: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CancelledConfirmDialog(
                                onCancelTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pop();
                                  BlocProvider.of<AwaitPickupBloc>(context).add(
                                    AwaitPickupCancelEvent(
                                      transactionID:
                                          state.transactions[index].id,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
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
