import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/screens/transaction_status/delivering/bloc/delivering_bloc.dart';
import 'package:book_store/screens/transaction_status/delivering/ui/delivering_item.dart';
import 'package:book_store/screens/transaction_status/ui/confirm_received_dialog.dart';
import 'package:book_store/screens/transaction_status/ui/empty_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_detail_receive_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveringTransactionPage extends StatelessWidget {
  const DeliveringTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveringBloc, DeliveringState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const TransactionLoadingPage();
        }

        if (state.transactions.isEmpty) {
          return const EmptyTransactionPage();
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return DeliveringItem(
              transactionData: state.transactions[index],
              onTap: () {
                Navigator.of(context)
                    .push(
                  PageRouteSlideTransition(
                    child: ReceivedTransactionDetailPage(
                      transactionData: state.transactions[index],
                      onReceive: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const ReceivedConfirmDialog();
                          },
                        ).then((value) {
                          if (value != null && value == true) {
                            Navigator.of(context).pop(true);
                          }
                        });
                      },
                    ),
                  ),
                )
                    .then((value) {
                  if (value != null && value == true) {
                    BlocProvider.of<DeliveringBloc>(context).add(
                      DeliveringReceiveEvent(
                        transactionID: state.transactions[index].id,
                      ),
                    );
                  }
                });
              },
              onReceived: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ReceivedConfirmDialog();
                  },
                ).then((value) {
                  if (value != null && value == true) {
                    BlocProvider.of<DeliveringBloc>(context).add(
                      DeliveringReceiveEvent(
                        transactionID: state.transactions[index].id,
                      ),
                    );
                  }
                });
              },
            );
          },
          itemCount: state.transactions.length,
        );
      },
    );
  }
}
