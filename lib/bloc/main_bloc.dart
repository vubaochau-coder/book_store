import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainLoadingState()) {
    on<MainLoadingEvent>(mainLoadingEvent);
    on<MainUpdateEvent>(mainUpdateEvent);
  }

  FutureOr<void> mainLoadingEvent(
      MainLoadingEvent event, Emitter<MainState> emit) {
    emit(MainLoadingState());
    int cartCount = 0;
    int messCount = 0;
    String userID = FirebaseAuth.instance.currentUser!.uid;
    final cartSnapshot = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Cart')
        .snapshots();
    cartSnapshot.listen((event) {
      cartCount = event.docs.length;
      add(MainUpdateEvent(cartNumber: cartCount, messageNumber: messCount));
    });
  }

  FutureOr<void> mainUpdateEvent(
      MainUpdateEvent event, Emitter<MainState> emit) {
    if (state is MainLoadingState) {
      emit(MainLoadingSuccessfulState(
          cartNumber: event.cartNumber, messNumber: event.messageNumber));
    } else if (state is MainLoadingSuccessfulState) {
      emit(MainLoadingSuccessfulState(
          cartNumber: event.cartNumber, messNumber: event.messageNumber));
    }
  }
}
