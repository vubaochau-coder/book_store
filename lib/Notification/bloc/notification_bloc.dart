import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoadingState()) {
    on<NotificationLoadingEvent>(notificationLoading);
    on<NotificationUpdateEvent>(notificationUpdate);
    on<NotificationEmptyEvent>(notificationEmpty);
  }

  FutureOr<void> notificationLoading(
      NotificationLoadingEvent event, Emitter<NotificationState> emit) {
    emit(NotificationLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Notification')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<NotificationModel> notiList = [];

        for (var ele in event.docs) {
          notiList.add(NotificationModel.fromSnapshot(ele));
        }

        add(NotificationUpdateEvent(newNotis: notiList));
      } else {
        add(NotificationEmptyEvent());
      }
    });
  }

  FutureOr<void> notificationUpdate(
      NotificationUpdateEvent event, Emitter<NotificationState> emit) {
    emit(NotificationLoadingSuccessfulState(
        notis: event.newNotis, sortType: 'all'));
  }

  FutureOr<void> notificationEmpty(
      NotificationEmptyEvent event, Emitter<NotificationState> emit) {
    emit(NotificationEmptyState());
  }
}
