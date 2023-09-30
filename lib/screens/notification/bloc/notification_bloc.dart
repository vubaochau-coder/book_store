import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/notification_model.dart';
import 'package:book_store/core/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  StreamSubscription? _streamSubscription;
  final NotificationRepository _notificationRepository;

  NotificationBloc(this._notificationRepository)
      : super(const NotificationState()) {
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

    _streamSubscription =
        _notificationRepository.streamUserNoti().listen((event) async {
      if (event.docs.isNotEmpty) {
        List<NotificationModel> notiList = [];
        for (var ele in event.docs) {
          notiList.add(NotificationModel.fromSnapshot(ele));
        }
        if (!isClosed) {
          add(NotificationUpdateEvent(newNotis: notiList));
        }
      } else {
        if (!isClosed) {
          add(const NotificationUpdateEvent(newNotis: []));
        }
      }
    });
  }

  _onUpdate(NotificationUpdateEvent event, Emitter emit) {
    List<NotificationModel> showed = [];
    if (state.sortType == NotiSortTypes.all) {
      showed = List.from(event.newNotis);
    }

    if (state.sortType == NotiSortTypes.read) {
      for (var ele in event.newNotis) {
        if (ele.isRead == true) {
          showed.add(ele);
        }
      }
    }

    if (state.sortType == NotiSortTypes.unRead) {
      for (var ele in event.newNotis) {
        if (ele.isRead == false) {
          showed.add(ele);
        }
      }
    }

    emit(
      state.copyWith(
        allNotis: event.newNotis,
        sortType: NotiSortTypes.all,
        isLoading: false,
        showedNotis: showed,
      ),
    );
  }

  _onFilter(NotificationFilterEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    List<NotificationModel> showed = [];
    if (event.filterType == NotiSortTypes.all) {
      showed = List.from(state.allNotis);
    }

    if (event.filterType == NotiSortTypes.read) {
      for (var ele in state.allNotis) {
        if (ele.isRead == true) {
          showed.add(ele);
        }
      }
    }

    if (event.filterType == NotiSortTypes.unRead) {
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
    await _notificationRepository.readNotiEvent(event.notiID);
  }

  _onReadAll(NotificationReadAllEvent event, Emitter emit) async {
    await _notificationRepository.readAllNotiEvent();
  }
}
