import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'cancelled_event.dart';
part 'cancelled_state.dart';

class CancelledBloc extends Bloc<CancelledEvent, CancelledState> {
  CancelledBloc() : super(CancelledLoadingState()) {
    on<CancelledLoadingEvent>(cancelledLoadingEvent);
    on<CancelledUpdateEvent>(cancelledUpdateEvent);
    on<CancelledUpdateEmptyEvent>(cancelledUpdateEmptyEvent);
  }

  FutureOr<void> cancelledLoadingEvent(
      CancelledLoadingEvent event, Emitter<CancelledState> emit) async {
    emit(CancelledLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .where('status', isEqualTo: -1)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        final transQuery = await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction')
            .where('status', isEqualTo: -1)
            .get();

        for (var ele in transQuery.docs) {
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
            double bookPrice = double.parse(bookQuery.get('price').toString());
            double bookDiscount =
                double.parse(bookQuery.get('discount').toString());
            String url = List.from(bookQuery.get('listURL'))[0];

            products.add(
              CartItemModel.fromSnapshot(
                  tempEle,
                  (bookPrice - bookPrice * bookDiscount),
                  bookPrice,
                  url,
                  bookTitle),
            );
          }

          list.add(TransactionModel.fromSnapshot(ele, products));
        }

        add(CancelledUpdateEvent(transactions: list));
      } else {
        add(CancelledUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> cancelledUpdateEvent(
      CancelledUpdateEvent event, Emitter<CancelledState> emit) {
    if (state is CancelledEmptyState || state is CancelledLoadingState) {
      emit(CancelledLoadingSuccessfulState(transactions: event.transactions));
    } else {
      final currentState = state as CancelledLoadingSuccessfulState;

      if (currentState.transactions.isNotEmpty) {
        currentState.transactions.clear();
      }

      emit(CancelledLoadingSuccessfulState(transactions: event.transactions));
    }
  }

  FutureOr<void> cancelledUpdateEmptyEvent(
      CancelledUpdateEmptyEvent event, Emitter<CancelledState> emit) {
    emit(CancelledEmptyState());
  }
}
