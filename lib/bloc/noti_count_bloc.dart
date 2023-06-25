import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'noti_count_event.dart';
part 'noti_count_state.dart';

class NotiCountBloc extends Bloc<NotiCountEvent, NotiCountState> {
  NotiCountBloc() : super(NotiCountLoadingState()) {
    on<NotiCountLoadingEvent>(loading);
    on<NotiCountUpdateEvent>(update);
  }

  FutureOr<void> loading(
      NotiCountLoadingEvent event, Emitter<NotiCountState> emit) {
    emit(NotiCountLoadingState());

    int notiCount = 0;

    String userID = FirebaseAuth.instance.currentUser!.uid;
    final notiSnapshot = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Notification')
        .where('isRead', isEqualTo: false)
        .snapshots();
    notiSnapshot.listen((event) {
      notiCount = event.docs.length;
      add(NotiCountUpdateEvent(notiCount: notiCount));
    });
  }

  FutureOr<void> update(
      NotiCountUpdateEvent event, Emitter<NotiCountState> emit) {
    emit(NotiCountLoadingSuccessfulState(notiCount: event.notiCount));
  }
}
