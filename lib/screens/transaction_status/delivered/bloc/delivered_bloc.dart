import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'delivered_event.dart';
part 'delivered_state.dart';

class DeliveredBloc extends Bloc<DeliveredEvent, DeliveredState> {
  DeliveredBloc() : super(DeliveredLoadingState()) {
    on<DeliveredLoadingEvent>(deliveredLoadingEvent);
    on<DeliveredUpdateEvent>(deliveredUpdateEvent);
    on<DeliveredUpdateEmptyEvent>(deliveredUpdateEmptyEvent);
  }

  FutureOr<void> deliveredLoadingEvent(
      DeliveredLoadingEvent event, Emitter<DeliveredState> emit) async {
    emit(DeliveredLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .where('status', isEqualTo: 3)
        .snapshots()
        .listen((snapshotEvent) async {
      if (snapshotEvent.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        for (var ele in snapshotEvent.docs) {
          List<CartItemModel> products = [];
          final productsQuery = await FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .collection('Transaction')
              .doc(ele.id)
              .collection('Products')
              .get();
          for (var tempEle in productsQuery.docs) {
            String bookID = tempEle.get('productID');
            final bookQuery = await FirebaseFirestore.instance
                .collection('Book')
                .doc(bookID)
                .get();

            String bookTitle = bookQuery.get('title');
            double bookPrice =
                double.parse(tempEle.get('priceBeforeDiscount').toString());
            double bookDiscount = 1 -
                double.parse(tempEle.get('price').toString()) /
                    double.parse(tempEle.get('priceBeforeDiscount').toString());
            String url = List.from(bookQuery.get('listURL'))[0];

            products.add(
              CartItemModel.fromSnapshot(
                tempEle,
                (bookPrice * (1 - bookDiscount)),
                bookPrice,
                url,
                bookTitle,
              ),
            );
          }

          list.add(TransactionModel.fromSnapshot(ele, products));
        }

        add(DeliveredUpdateEvent(transactions: list));
      } else {
        add(DeliveredUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> deliveredUpdateEvent(
      DeliveredUpdateEvent event, Emitter<DeliveredState> emit) {
    if (state is DeliveredLoadingState || state is DeliveredEmptyState) {
      emit(DeliveredLoadingSuccessfulState(transactions: event.transactions));
    } else if (state is DeliveredLoadingSuccessfulState) {
      final currentState = state as DeliveredLoadingSuccessfulState;

      if (currentState.transactions.isNotEmpty) {
        currentState.transactions.clear();
      }

      emit(DeliveredLoadingSuccessfulState(transactions: event.transactions));
    }
  }

  FutureOr<void> deliveredUpdateEmptyEvent(
      DeliveredUpdateEmptyEvent event, Emitter<DeliveredState> emit) {
    emit(DeliveredEmptyState());
  }
}
