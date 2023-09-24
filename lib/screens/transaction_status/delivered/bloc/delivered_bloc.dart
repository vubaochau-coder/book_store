import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/core/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';

part 'delivered_event.dart';
part 'delivered_state.dart';

class DeliveredBloc extends Bloc<DeliveredEvent, DeliveredState> {
  StreamSubscription? _bookingStream;
  final TransactionRepository _transactionRepository;

  DeliveredBloc(this._transactionRepository) : super(const DeliveredState()) {
    on<DeliveredLoadingEvent>(_onLoading);
    on<DeliveredUpdateEvent>(_onUpdate);
    on<DeliveredUpdateEmptyEvent>(_onEmpty);
  }

  @override
  Future<void> close() async {
    _bookingStream?.cancel();
    _bookingStream = null;
    super.close();
  }

  _onLoading(DeliveredLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    // String uid = FirebaseAuth.instance.currentUser!.uid;

    _bookingStream = _transactionRepository
        .transactionStream(3)
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
          add(DeliveredUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(DeliveredUpdateEmptyEvent());
        }
      }
    });
  }

  _onUpdate(DeliveredUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: event.transactions,
      ),
    );
  }

  _onEmpty(DeliveredUpdateEmptyEvent event, Emitter emit) {
    emit(state.copyWith(
      isLoading: false,
      transactions: [],
    ));
  }
}
