import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  StreamSubscription? _streamSubscription;

  NotificationBloc() : super(const NotificationState()) {
    on<NotificationLoadingEvent>(_onLoading);
    on<NotificationUpdateEvent>(_onUpdate);
    on<NotificationFilterEvent>(_onFilter);
    on<NotificationTappedEvent>(_onItemTapped);
    on<NotificationReadAllEvent>(_onReadAll);
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.close();
  }

  _onLoading(NotificationLoadingEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: true));

    String uid = FirebaseAuth.instance.currentUser!.uid;

    _streamSubscription = FirebaseFirestore.instance
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

  _onUpdate(NotificationUpdateEvent event, Emitter emit) {
    List<NotificationModel> showed = [];
    if (state.sortType == SortTypes.all) {
      showed = List.from(event.newNotis);
    }

    if (state.sortType == SortTypes.read) {
      for (var ele in event.newNotis) {
        if (ele.isRead == true) {
          showed.add(ele);
        }
      }
    }

    if (state.sortType == SortTypes.unRead) {
      for (var ele in event.newNotis) {
        if (ele.isRead == false) {
          showed.add(ele);
        }
      }
    }

    emit(
      state.copyWith(
        allNotis: event.newNotis,
        sortType: SortTypes.all,
        isLoading: false,
        showedNotis: showed,
      ),
    );
  }

  _onFilter(NotificationFilterEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    List<NotificationModel> showed = [];
    if (event.filterType == SortTypes.all) {
      showed = List.from(state.allNotis);
    }

    if (event.filterType == SortTypes.read) {
      for (var ele in state.allNotis) {
        if (ele.isRead == true) {
          showed.add(ele);
        }
      }
    }

    if (event.filterType == SortTypes.unRead) {
      for (var ele in state.allNotis) {
        if (ele.isRead == false) {
          showed.add(ele);
        }
      }
    }

    emit(
      state.copyWith(
        sortType: event.filterType,
        showedNotis: showed,
        isLoading: false,
      ),
    );
  }

  _onItemTapped(NotificationTappedEvent event, Emitter emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final notiDocRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Notification')
        .doc(event.notiID);
    await notiDocRef.update({'isRead': true});
  }

  _onReadAll(NotificationReadAllEvent event, Emitter emit) async {
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
