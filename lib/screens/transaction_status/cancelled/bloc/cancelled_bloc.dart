import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/core/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';

part 'cancelled_event.dart';
part 'cancelled_state.dart';

class CancelledBloc extends Bloc<CancelledEvent, CancelledState> {
  StreamSubscription? _bookingStream;
  final TransactionRepository _transactionRepository;

  CancelledBloc(this._transactionRepository) : super(const CancelledState()) {
    on<CancelledLoadingEvent>(_onLoading);
    on<CancelledUpdateEvent>(_onUpdate);
    on<CancelledUpdateEmptyEvent>(_onEmpty);
  }

  @override
  Future<void> close() async {
    _bookingStream?.cancel();
    _bookingStream = null;
    super.close();
  }

  _onLoading(CancelledLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _bookingStream = _transactionRepository
        .transactionStream(-1)
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
          add(CancelledUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(CancelledUpdateEmptyEvent());
        }
      }
    });
  }

  _onUpdate(CancelledUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: event.transactions,
      ),
    );
  }

  _onEmpty(CancelledUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: [],
      ),
    );
  }
}
