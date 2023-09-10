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
    on<NotificationLoadingEvent>(_loading);
    on<NotificationUpdateEvent>(_update);
    on<NotificationFilterEvent>(_filter);
    on<NotificationTappedEvent>(_itemTapped);
    on<NotificationReadAllEvent>(_readAll);
  }

  FutureOr<void> _loading(
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
        add(const NotificationUpdateEvent(newNotis: []));
      }
    });
  }

  FutureOr<void> _update(
      NotificationUpdateEvent event, Emitter<NotificationState> emit) {
    emit(NotificationLoadingSuccessfulState(
        notis: event.newNotis, sortType: 'all'));
  }

  FutureOr<void> _filter(
      NotificationFilterEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;
    List<NotificationModel> newNoti = [];

    final notiCollection = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Notification');

    if (event.filterType == 'all') //Get all notification
    {
      final notiQuery =
          await notiCollection.orderBy('date', descending: true).get();
      for (var ele in notiQuery.docs) {
        newNoti.add(NotificationModel.fromSnapshot(ele));
      }
    } else if (event.filterType == 'unread') //Get unread notification
    {
      final notiQuery = await notiCollection
          .where('isRead', isEqualTo: false)
          .orderBy('date', descending: true)
          .get();
      for (var ele in notiQuery.docs) {
        newNoti.add(NotificationModel.fromSnapshot(ele));
      }
    } else if (event.filterType == 'read') //Get read notifiation
    {
      final notiQuery = await notiCollection
          .where('isRead', isEqualTo: true)
          .orderBy('date', descending: true)
          .get();
      for (var ele in notiQuery.docs) {
        newNoti.add(NotificationModel.fromSnapshot(ele));
      }
    }

    emit(NotificationLoadingSuccessfulState(
        notis: newNoti, sortType: event.filterType));
  }

  FutureOr<void> _itemTapped(
      NotificationTappedEvent event, Emitter<NotificationState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final notiDocRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Notification')
        .doc(event.notiID);
    await notiDocRef.update({'isRead': true});
  }

  FutureOr<void> _readAll(
      NotificationReadAllEvent event, Emitter<NotificationState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final notiColRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Notification');

    final notiQuery = await notiColRef.where('isRead', isEqualTo: false).get();

    for (var ele in notiQuery.docs) {
      await ele.reference.update({'isRead': true});
    }
  }
}
