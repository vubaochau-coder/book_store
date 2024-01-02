import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/core/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/models/cart_item_model.dart';
import '../../../../core/repositories/transaction_repository.dart';

part 'unconfirmed_event.dart';
part 'unconfirmed_state.dart';

class UnconfirmedBloc extends Bloc<UnconfirmedEvent, UnconfirmedState> {
  StreamSubscription? _bookingStream;
  final TransactionRepository _transactionRepository;
  final NotificationRepository _notificationRepository;

  UnconfirmedBloc(this._transactionRepository, this._notificationRepository)
      : super(const UnconfirmedState()) {
    on<UnconfirmedLoadingEvent>(_onLoading);
    on<UnconfirmedUpdateEvent>(_onUpdate);
    on<UnconfirmedUpdateEmptyEvent>(_onEmpty);
    on<UnconfirmedCancelEvent>(_onCancel);
  }

  @override
  Future<void> close() async {
    _bookingStream?.cancel();
    _bookingStream = null;
    super.close();
  }

  _onLoading(UnconfirmedLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _bookingStream = _transactionRepository
        .transactionStream([0]).listen((snapshotEvent) async {
      if (snapshotEvent.docs.isNotEmpty) {
        List<TransactionModel> list = [];

        // final futureGroup = await Future.wait(
        //   snapshotEvent.docs.map(
        //     (e) => _transactionRepository.getAllProductOfTransaction(e.id),
        //   ),
        // );

        // for (int i = 0; i < snapshotEvent.size; i++) {
        //   list.add(
        //     TransactionModel.fromSnapshot(
        //       snapshotEvent.docs[i],
        //       futureGroup[i],
        //     ),
        //   );
        // }

        for (int i = 0; i < snapshotEvent.size; i++) {
          List<CartItemModel> prs = [];

          List<Map<String, dynamic>> rawPrs =
              List.from(snapshotEvent.docs[i].data()['products']);

          final productsInfo = await Future.wait(
            rawPrs.map(
              (e) => _transactionRepository.getOrderProduct(e['productID']),
            ),
          );

          for (int j = 0; j < rawPrs.length; j++) {
            CartItemModel cartItem = CartItemModel(
              id: '',
              bookID: rawPrs[j]['productID'],
              count: rawPrs[j]['count'],
              price: rawPrs[j]['price'],
              imgUrl: productsInfo[j]['imgURL'],
              title: productsInfo[j]['productName'],
              priceBeforeDiscount: rawPrs[j]['priceBeforeDiscount'],
            );

            prs.add(cartItem);
          }

          list.add(
            TransactionModel.fromSnapshot(
              snapshotEvent.docs[i],
              // futureGroup[i],
              prs,
            ),
          );
        }

        if (!isClosed) {
          add(UnconfirmedUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(UnconfirmedUpdateEmptyEvent());
        }
      }
    });
  }

  _onUpdate(UnconfirmedUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: event.transactions,
      ),
    );
  }

  _onEmpty(UnconfirmedUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: [],
      ),
    );
  }

  _onCancel(UnconfirmedCancelEvent event, Emitter emit) async {
    await _transactionRepository
        .cancelTransaction(event.transactionID)
        .then((value) async {
      await Future.wait([
        _notificationRepository
            .createCancelTransactionNoti(event.transactionID),
        _notificationRepository.sendCancelNotiToAdmin(event.transactionID),
      ]);

      Fluttertoast.showToast(msg: 'Hủy đơn hàng thành công');
    });
  }
}
