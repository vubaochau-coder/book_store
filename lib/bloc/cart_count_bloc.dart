import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'cart_count_event.dart';
part 'cart_count_state.dart';

class CartCountBloc extends Bloc<CartCountEvent, CartCountState> {
  CartCountBloc() : super(CartCountLoadingState()) {
    on<CartCountLoadingEvent>(cartCountLoadingEvent);
    on<CartCountUpdateEvent>(cartCountUpdateEvent);
  }

  FutureOr<void> cartCountLoadingEvent(
      CartCountLoadingEvent event, Emitter<CartCountState> emit) {
    emit(CartCountLoadingState());
    int cartCount = 0;
    String userID = FirebaseAuth.instance.currentUser!.uid;
    final cartSnapshot = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Cart')
        .snapshots();
    cartSnapshot.listen((event) {
      cartCount = event.docs.length;
      add(CartCountUpdateEvent(cartNumber: cartCount));
    });
  }

  FutureOr<void> cartCountUpdateEvent(
      CartCountUpdateEvent event, Emitter<CartCountState> emit) {
    if (state is CartCountLoadingState) {
      emit(CartCountLoadingSuccessfulState(cartNumber: event.cartNumber));
    } else if (state is CartCountLoadingSuccessfulState) {
      emit(CartCountLoadingSuccessfulState(cartNumber: event.cartNumber));
    }
  }
}
