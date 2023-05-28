import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'await_pickup_event.dart';
part 'await_pickup_state.dart';

class AwaitPickupBloc extends Bloc<AwaitPickupEvent, AwaitPickupState> {
  AwaitPickupBloc() : super(AwaitPickupLoadingState()) {
    on<AwaitPickupLoadingEvent>(awaitPickupLoadingEvent);
    on<AwaitPickupUpdateEvent>(awaitPickupUpdateEvent);
    on<AwaitPickupUpdateEmptyEvent>(awaitPicupUpdateEmptyEvent);
    on<AwaitPickupCancelEvent>(awaitPickupCancelEvent);
  }

  FutureOr<void> awaitPickupLoadingEvent(
      AwaitPickupLoadingEvent event, Emitter<AwaitPickupState> emit) async {
    emit(AwaitPickupLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .where('status', isEqualTo: 1)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        final transQuery = await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction')
            .where('status', isEqualTo: 1)
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

        add(AwaitPickupUpdateEvent(transactions: list));
      } else {
        add(AwaitPickupUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> awaitPickupUpdateEvent(
      AwaitPickupUpdateEvent event, Emitter<AwaitPickupState> emit) {
    if (state is AwaitPickupLoadingState || state is AwaitPickupEmptyState) {
      emit(AwaitPickupLoadingSuccessfulState(transactions: event.transactions));
    } else if (state is AwaitPickupLoadingSuccessfulState) {
      final currentState = state as AwaitPickupLoadingSuccessfulState;

      if (currentState.transactions.isNotEmpty) {
        currentState.transactions.clear();
      }

      emit(AwaitPickupLoadingSuccessfulState(transactions: event.transactions));
    }
  }

  FutureOr<void> awaitPicupUpdateEmptyEvent(
      AwaitPickupUpdateEmptyEvent event, Emitter<AwaitPickupState> emit) {
    emit(AwaitPickupEmptyState());
  }

  FutureOr<void> awaitPickupCancelEvent(
      AwaitPickupCancelEvent event, Emitter<AwaitPickupState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .doc(event.transactionID);

    await docRef.update({
      'status': -1,
    }).then((value) {
      Fluttertoast.showToast(msg: 'Hủy đơn hàng thành công');
    });
  }
}
