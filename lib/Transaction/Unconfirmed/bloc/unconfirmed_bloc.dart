import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'unconfirmed_event.dart';
part 'unconfirmed_state.dart';

class UnconfirmedBloc extends Bloc<UnconfirmedEvent, UnconfirmedState> {
  UnconfirmedBloc() : super(UnconfirmedLoadingState()) {
    on<UnconfirmedLoadingEvent>(unconfirmedLoadingEvent);
    on<UnconfirmedUpdateEvent>(unconfirmedUpdateEvent);
    on<UnconfirmedUpdateEmptyEvent>(unconfirmedUpdateEmptyEvent);
    on<UnconfirmedCancelEvent>(unconfirmedCancelEvent);
  }

  FutureOr<void> unconfirmedLoadingEvent(
      UnconfirmedLoadingEvent event, Emitter<UnconfirmedState> emit) async {
    emit(UnconfirmedLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .where('status', isEqualTo: 0)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        final transQuery = await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction')
            .where('status', isEqualTo: 0)
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

        add(UnconfirmedUpdateEvent(transactions: list));
      } else {
        add(UnconfirmedUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> unconfirmedUpdateEvent(
      UnconfirmedUpdateEvent event, Emitter<UnconfirmedState> emit) {
    if (state is UnconfirmedLoadingState || state is UnconfirmedEmptyState) {
      emit(UnconfrimedLoadingSuccessfulState(transactions: event.transactions));
    } else if (state is UnconfrimedLoadingSuccessfulState) {
      final currentState = state as UnconfrimedLoadingSuccessfulState;

      if (currentState.transactions.isNotEmpty) {
        currentState.transactions.clear();
      }

      emit(UnconfrimedLoadingSuccessfulState(transactions: event.transactions));
    }
  }

  FutureOr<void> unconfirmedUpdateEmptyEvent(
      UnconfirmedUpdateEmptyEvent event, Emitter<UnconfirmedState> emit) {
    emit(UnconfirmedEmptyState());
  }

  FutureOr<void> unconfirmedCancelEvent(
      UnconfirmedCancelEvent event, Emitter<UnconfirmedState> emit) async {
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
