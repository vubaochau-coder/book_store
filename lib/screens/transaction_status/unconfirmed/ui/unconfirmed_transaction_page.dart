import 'package:book_store/custom_widgets/custom_page_route.dart';
import '../bloc/unconfirmed_bloc.dart';
import 'unconfirmed_transaction_item.dart';
import 'package:book_store/screens/transaction_status/ui/confirm_cancelled_dialog.dart';
import 'package:book_store/screens/transaction_status/ui/empty_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_detail_cancel_page.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnconfrimedTransactionPage extends StatelessWidget {
  const UnconfrimedTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnconfirmedBloc, UnconfirmedState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const TransactionLoadingPage();
        }

        if (state.transactions.isEmpty) {
          return const EmptyTransactionPage();
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return UnconfirmedTransactionItem(
              transactionData: state.transactions[index],
              onTap: () {
                Navigator.of(context)
                    .push(
                  PageRouteSlideTransition(
                    child: CanCancelledTransactionDetailPage(
                      transactionData: state.transactions[index],
                      onCancelled: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const CancelledConfirmDialog();
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
                    BlocProvider.of<UnconfirmedBloc>(context).add(
                      UnconfirmedCancelEvent(
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
