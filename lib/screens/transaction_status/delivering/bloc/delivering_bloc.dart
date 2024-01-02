import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/core/repositories/book_repository.dart';
import 'package:book_store/core/repositories/feedback_repository.dart';
import 'package:book_store/core/repositories/notification_repository.dart';
import 'package:book_store/core/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'delivering_event.dart';
part 'delivering_state.dart';

class DeliveringBloc extends Bloc<DeliveringEvent, DeliveringState> {
  StreamSubscription? _bookingStream;
  final TransactionRepository _transactionRepository;
  final NotificationRepository _notificationRepository;
  final BookRepository _bookRepository;
  final FeedbackRepository _feedbackRepository;

  DeliveringBloc(this._transactionRepository, this._notificationRepository,
      this._bookRepository, this._feedbackRepository)
      : super(const DeliveringState()) {
    on<DeliveringLoadingEvent>(_onLoading);
    on<DeliveringUpdateEvent>(_onUpdate);
    on<DeliveringUpdateEmptyEvent>(_onEmpty);
    on<DeliveringReceiveEvent>(_onReceiveTransaction);
  }

  @override
  Future<void> close() async {
    _bookingStream?.cancel();
    _bookingStream = null;
    super.close();
  }

  _onLoading(DeliveringLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _bookingStream = _transactionRepository
        .transactionStream([3]).listen((snapshotEvent) async {
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
          add(DeliveringUpdateEvent(transactions: list));
        }
      } else {
        if (!isClosed) {
          add(DeliveringUpdateEmptyEvent());
        }
      }
    });
  }

  _onUpdate(DeliveringUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: event.transactions,
      ),
    );
  }

  _onEmpty(DeliveringUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        transactions: [],
      ),
    );
  }

  _onReceiveTransaction(DeliveringReceiveEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    await _transactionRepository
        .receiveTransaction(event.transactionID)
        .then((value) async {
      final futureGroup = await Future.wait([
        _notificationRepository
            .createReceiveTransactionNoti(event.transactionID),
        _notificationRepository.sendReceiveNotiToAdmin(event.transactionID),
        _transactionRepository.getAllProductOfTransaction(event.transactionID),
      ]);

      List<CartItemModel> products = futureGroup[1] as List<CartItemModel>;

      await Future.wait([
        ...products
            .map((e) => _bookRepository.increateTotalSold(e.bookID, e.count)),
        ...products.map((e) => _feedbackRepository.addNewFeedback(
            e.bookID, e.title, e.price, e.imgUrl))
      ]);

      Fluttertoast.showToast(msg: 'Nhận đơn hàng thành công');
    });
  }
}
