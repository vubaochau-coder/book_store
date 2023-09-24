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
  StreamSubscription? _bookingStream;

  CancelledBloc() : super(const CancelledState()) {
    on<CancelledLoadingEvent>(_onLoading);
    on<CancelledUpdateEvent>(_onUpdate);
    on<CancelledUpdateEmptyEvent>(_onEmpty);
  }

  @override
  Future<void> close() async {
    _bookingStream?.cancel();
    _bookingStream = null;
    super.close();
  }

  _onLoading(CancelledLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    String uid = FirebaseAuth.instance.currentUser!.uid;

    _bookingStream = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .where('status', isEqualTo: -1)
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
          add(CancelledUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(CancelledUpdateEmptyEvent());
        }
      }
    });
  }

  _onUpdate(CancelledUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: event.transactions,
      ),
    );
  }

  _onEmpty(CancelledUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: [],
      ),
    );
  }
}
