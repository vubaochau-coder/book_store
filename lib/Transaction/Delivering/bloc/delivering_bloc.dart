import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'delivering_event.dart';
part 'delivering_state.dart';

class DeliveringBloc extends Bloc<DeliveringEvent, DeliveringState> {
  DeliveringBloc() : super(DeliveringLoadingState()) {
    on<DeliveringLoadingEvent>(deliveringLoadingEvent);
    on<DeliveringUpdateEvent>(deliveringUpdateEvent);
    on<DeliveringUpdateEmptyEvent>(deliveringUpdateEmptyEvent);
    on<DeliveringReceiveEvent>(deliveringReceiveEvent);
  }

  FutureOr<void> deliveringLoadingEvent(
      DeliveringLoadingEvent event, Emitter<DeliveringState> emit) async {
    emit(DeliveringLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .where('status', isEqualTo: 2)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        final transQuery = await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction')
            .where('status', isEqualTo: 2)
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

        add(DeliveringUpdateEvent(transactions: list));
      } else {
        add(DeliveringUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> deliveringUpdateEvent(
      DeliveringUpdateEvent event, Emitter<DeliveringState> emit) {
    if (state is DeliveringLoadingState || state is DeliveringEmptyState) {
      emit(DeliveringLoadingSuccessfulState(transactions: event.transactions));
    } else if (state is DeliveringLoadingSuccessfulState) {
      final currentState = state as DeliveringLoadingSuccessfulState;

      if (currentState.transactions.isNotEmpty) {
        currentState.transactions.clear();
      }

      emit(DeliveringLoadingSuccessfulState(transactions: event.transactions));
    }
  }

  FutureOr<void> deliveringUpdateEmptyEvent(
      DeliveringUpdateEmptyEvent event, Emitter<DeliveringState> emit) {
    emit(DeliveringEmptyState());
  }

  FutureOr<void> deliveringReceiveEvent(
      DeliveringReceiveEvent event, Emitter<DeliveringState> emit) async {
    emit(DeliveringLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .doc(event.transactionID);

    await docRef.update({
      'dateCompleted': Converter.convertDateToString(DateTime.now()),
      'status': 3,
    }).then((value) async {
      final productsQuery = await FirebaseFirestore.instance
          .collection("User")
          .doc(uid)
          .collection('Transaction')
          .doc(event.transactionID)
          .collection('Products')
          .get();
      for (var item in productsQuery.docs) {
        String productID = item.get('productID');
        final bookRef =
            FirebaseFirestore.instance.collection('Book').doc(productID);
        final totalSold = await bookRef.get();
        int temp = int.parse(totalSold.get('totalSold').toString());
        temp += int.parse(item.get('count').toString());
        await bookRef.update({'totalSold': temp});
      }
      // add(DeliveringLoadingEvent());
    });
  }
}
