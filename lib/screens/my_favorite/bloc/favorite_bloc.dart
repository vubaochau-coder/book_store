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
  StreamSubscription? _favoriteStream;

  FavoriteBloc() : super(const FavoriteState()) {
    on<FavoriteLoadingEvent>(_onLoading);
    on<FavoriteRemoveEvent>(_onRemove);
    on<FavoriteUpdateEvent>(_onUpdate);
    on<FavoriteUpdateEmptyEvent>(_onUpdateEmpty);
  }

  @override
  Future<void> close() async {
    _favoriteStream?.cancel();
    _favoriteStream = null;
    super.close();
  }

  _onLoading(FavoriteLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    String uid = FirebaseAuth.instance.currentUser!.uid;

    _favoriteStream = FirebaseFirestore.instance
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

  _onRemove(FavoriteRemoveEvent event, Emitter emit) async {
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

  _onUpdate(FavoriteUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        listFavorite: event.listFavorite,
      ),
    );
  }

  _onUpdateEmpty(FavoriteUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        listFavorite: [],
      ),
    );
  }
}
