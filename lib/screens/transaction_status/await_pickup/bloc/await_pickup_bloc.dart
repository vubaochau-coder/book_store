import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/core/repositories/notification_repository.dart';
import 'package:book_store/core/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'await_pickup_event.dart';
part 'await_pickup_state.dart';

class AwaitPickupBloc extends Bloc<AwaitPickupEvent, AwaitPickupState> {
  StreamSubscription? _bookingStream;
  final TransactionRepository _transactionRepository;
  final NotificationRepository _notificationRepository;

  AwaitPickupBloc(this._transactionRepository, this._notificationRepository)
      : super(const AwaitPickupState()) {
    on<AwaitPickupLoadingEvent>(_onLoading);
    on<AwaitPickupUpdateEvent>(_onUpdate);
    on<AwaitPickupUpdateEmptyEvent>(_onEmpty);
    on<AwaitPickupCancelEvent>(_onCancel);
  }

  @override
  Future<void> close() async {
    _bookingStream?.cancel();
    _bookingStream = null;
    super.close();
  }

  _onLoading(AwaitPickupLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _bookingStream = _transactionRepository
        .transactionStream(1)
        .listen((snapshotEvent) async {
      if (snapshotEvent.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        final futureGroup = await Future.wait(
          snapshotEvent.docs.map(
            (e) => _transactionRepository.getAllProductOfTransaction(e.id),
          ),
        );

        for (int i = 0; i < snapshotEvent.size; i++) {
          list.add(
            TransactionModel.fromSnapshot(
              snapshotEvent.docs[i],
              futureGroup[i],
            ),
          );
        }

        if (!isClosed) {
          add(AwaitPickupUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(AwaitPickupUpdateEmptyEvent());
        }
      }
    });
  }

  _onUpdate(AwaitPickupUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: event.transactions,
      ),
    );
  }

  _onEmpty(AwaitPickupUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: [],
      ),
    );
  }

  _onCancel(AwaitPickupCancelEvent event, Emitter emit) async {
    await _transactionRepository
        .cancelTransaction(event.transactionID)
        .then((value) async {
      await _notificationRepository
          .createCancelTransactionNoti(event.transactionID);
      Fluttertoast.showToast(msg: 'Hủy đơn hàng thành công');
    });
  }
}
