import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/favorite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoadingState()) {
    on<FavoriteLoadingEvent>(favoriteLoadingEvent);
    on<FavoriteRemoveEvent>(favoriteRemoveEvent);
    on<FavoriteUpdateEvent>(favoriteUpdateEvent);
    on<FavoriteUpdateEmptyEvent>(favoriteUpdateEmptyEvent);
  }

  FutureOr<void> favoriteLoadingEvent(
      FavoriteLoadingEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Favorite')
        .snapshots()
        .listen((snapshotEvent) async {
      if (snapshotEvent.docs.isNotEmpty) {
        List<FavoriteModel> listFavorite = [];

        for (var ele in snapshotEvent.docs) {
          String productID = ele.get('productID');
          final productQuery = await FirebaseFirestore.instance
              .collection('Book')
              .doc(productID)
              .get();
          String bookTitle = productQuery.get('title');
          String bookURL = List.from(productQuery.get('listURL'))[0];
          double bookPrice = productQuery.get('price');
          double discount = productQuery.get('discount');

          FavoriteModel temp = FavoriteModel(
            id: ele.id,
            productID: productID,
            productTitle: bookTitle,
            imgURL: bookURL,
            price: bookPrice * (1 - discount),
          );

          listFavorite.add(temp);
        }

        add(FavoriteUpdateEvent(listFavorite: listFavorite));
      } else {
        add(FavoriteUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> favoriteRemoveEvent(
      FavoriteRemoveEvent event, Emitter<FavoriteState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Favorite')
        .doc(event.idDocument);

    await docRef.delete().then(
          (value) =>
              Fluttertoast.showToast(msg: 'Bỏ thích sản phẩm thành công'),
        );
  }

  FutureOr<void> favoriteUpdateEvent(
      FavoriteUpdateEvent event, Emitter<FavoriteState> emit) {
    if (state is FavoriteLoadingState || state is FavoriteEmptyState) {
      emit(FavoriteLoadingSuccessfulState(listFavorite: event.listFavorite));
    } else if (state is FavoriteLoadingSuccessfulState) {
      final currentState = state as FavoriteLoadingSuccessfulState;

      if (currentState.listFavorite.isNotEmpty) {
        currentState.listFavorite.clear();
      }

      emit(FavoriteLoadingSuccessfulState(listFavorite: event.listFavorite));
    }
  }

  FutureOr<void> favoriteUpdateEmptyEvent(
      FavoriteUpdateEmptyEvent event, Emitter<FavoriteState> emit) {
    emit(FavoriteEmptyState());
  }
}
