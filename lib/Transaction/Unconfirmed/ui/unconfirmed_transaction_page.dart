import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/Transaction/Unconfirmed/bloc/unconfirmed_bloc.dart';
import 'package:book_store/Transaction/Unconfirmed/ui/unconfirmed_transaction_item.dart';
import 'package:book_store/Transaction/ui/confirm_cancelled_dialog.dart';
import 'package:book_store/Transaction/ui/empty_page.dart';
import 'package:book_store/Transaction/ui/transaction_detail_cancel_page.dart';
import 'package:book_store/Transaction/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnconfrimedTransactionPage extends StatelessWidget {
  const UnconfrimedTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnconfirmedBloc, UnconfirmedState>(
      builder: (context, state) {
        if (state is UnconfirmedEmptyState) {
          return const EmptyTransactionPage();
        } else if (state is UnconfirmedLoadingState) {
          return const TransactionLoadingPage();
        } else if (state is UnconfrimedLoadingSuccessfulState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return UnconfirmedTransactionItem(
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
                                  BlocProvider.of<UnconfirmedBloc>(context).add(
                                    UnconfirmedCancelEvent(
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
