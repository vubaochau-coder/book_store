import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/Transaction/Delivering/bloc/delivering_bloc.dart';
import 'package:book_store/Transaction/Delivering/ui/delivering_item.dart';
import 'package:book_store/Transaction/ui/confirm_received_dialog.dart';
import 'package:book_store/Transaction/ui/empty_page.dart';
import 'package:book_store/Transaction/ui/transaction_detail_receive_page.dart';
import 'package:book_store/Transaction/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveringTransactionPage extends StatelessWidget {
  const DeliveringTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveringBloc, DeliveringState>(
      builder: (context, state) {
        if (state is DeliveringEmptyState) {
          return const EmptyTransactionPage();
        } else if (state is DeliveringLoadingState) {
          return const TransactionLoadingPage();
        } else if (state is DeliveringLoadingSuccessfulState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return DeliveringItem(
                transactionData: state.transactions[index],
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteSlideTransition(
                      child: ReceivedTransactionDetailPage(
                        transactionData: state.transactions[index],
                        onReceive: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ReceivedConfirmDialog(
                                onReceiveTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pop();
                                  BlocProvider.of<DeliveringBloc>(context).add(
                                    DeliveringReceiveEvent(
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
                onReceived: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ReceivedConfirmDialog(
                        onReceiveTap: () {
                          Navigator.pop(context);
                          BlocProvider.of<DeliveringBloc>(context).add(
                            DeliveringReceiveEvent(
                              transactionID: state.transactions[index].id,
                            ),
                          );
                        },
                      );
                    },
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
