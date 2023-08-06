import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/notification_model.dart';
import 'package:book_store/models/transaction_model.dart';
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
      'dateCompleted': DateTime.now(),
      'status': 3,
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Notification')
          .add(createNotification(event.transactionID).toJson());

      final productsQuery = await FirebaseFirestore.instance
          .collection("User")
          .doc(uid)
          .collection('Transaction')
          .doc(event.transactionID)
          .collection('Products')
          .get();

      for (var item in productsQuery.docs) {
        String productID = item.get('productID');

        //Update totalSold of book
        final bookRef =
            FirebaseFirestore.instance.collection('Book').doc(productID);
        final book = await bookRef.get();
        int temp = int.parse(book.get('totalSold').toString());
        temp += int.parse(item.get('count').toString());
        await bookRef.update({'totalSold': temp});

        //Add product to Feedback collection
        final feedbackCollection = FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Feedback');
        await feedbackCollection.add({
          'productID': productID,
          'price': item.get('price'),
          'bookTitle': book.get('title'),
          'imgURL': List.from(book.get('listURL'))[0],
        });
      }
    });
  }

  NotificationModel createNotification(String checkOutID) {
    return NotificationModel(
      id: '',
      title: 'Giao hàng thành công',
      content:
          'Đơn hàng $checkOutID của bạn đã được giao thành công. Hãy sớm cho chúng tôi biết cảm nhận của bạn sau khi trải nghiệm sản phẩm nhé!',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_3',
    );
  }
}
