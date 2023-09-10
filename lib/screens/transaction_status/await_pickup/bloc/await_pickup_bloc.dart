import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/notification_model.dart';
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

        if (!isClosed) {
          add(AwaitPickupUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(AwaitPickupUpdateEmptyEvent());
        }
      }
    });
  }

  FutureOr<void> awaitPickupUpdateEvent(
      AwaitPickupUpdateEvent event, Emitter<AwaitPickupState> emit) {
    emit(AwaitPickupLoadingSuccessfulState(transactions: event.transactions));
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
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Notification')
          .add(createNotification(event.transactionID).toJson());

      Fluttertoast.showToast(msg: 'Hủy đơn hàng thành công');
    });
  }

  NotificationModel createNotification(String checkOutID) {
    return NotificationModel(
      id: '',
      title: 'Đơn hàng đã bị hủy',
      content:
          'Đơn hàng $checkOutID của bạn đã bị hủy. Bạn có thể mua lại các sản phẩm trong đơn hàng bất kỳ lúc nào trong mục "Đơn hàng của tôi" - "Đã hủy".',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_-1',
    );
  }
}
