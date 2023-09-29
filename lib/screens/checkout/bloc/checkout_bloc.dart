import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/address_model.dart';
import 'package:book_store/core/models/create_order_response.dart';
import 'package:book_store/core/models/notification_model.dart';
import 'package:book_store/core/models/payment_method_model.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/core/models/transport_model.dart';
import 'package:book_store/core/repositories/address_repository.dart';
import 'package:book_store/utils/zalopay_app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
  StreamSubscription? _addressStream;
  final AddressRepository _addressRepository;

  CheckoutBloc(this._addressRepository)
      : super(const CheckoutState(isLoading: true)) {
    on<CheckoutLoadingEvent>(_onLoading);
    on<CheckoutUpdateEmptyAddressEvent>(_onUpdateEmptyAddress);
    on<CheckoutUpdateAddressEvent>(_onUpdateAdrress);
    on<CheckoutSimpleOrderEvent>(_onOder);
    on<CheckoutZaloPayOrderEvent>(_onZaloPayOrder);
    on<CheckoutUpdatePaymentMethodEvent>(_onUpdatePaymentMethod);
    on<CheckoutUpdateTransportEvent>(_onUpdateTransport);
  }

  @override
  Future<void> close() async {
    _addressStream?.cancel();
    _addressStream = null;
    super.close();
  }

  _onLoading(CheckoutLoadingEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: true));
    _addressStream = _addressRepository
        .userMainAddressStream()
        .listen((firebaseEvent) async {
      if (firebaseEvent.docs.isNotEmpty) {
        AddressModel userAddress =
            AddressModel.fromSnapshot(firebaseEvent.docs.first);

        add(CheckoutUpdateAddressEvent(newAddress: userAddress));
      } else {
        List<TransportModel> transports = [];

        final transportQuery =
            await FirebaseFirestore.instance.collection('Transport').get();
        for (int i = 0; i < transportQuery.size; i++) {
          transports
              .add(TransportModel.fromSnapshot(transportQuery.docs[i], i == 0));
        }
        add(CheckoutUpdateEmptyAddressEvent(transports: transports));
      }
    });
  }

  _onUpdateAdrress(CheckoutUpdateAddressEvent event, Emitter emit) async {
    if (state.isLoading) {
      List<TransportModel> transports = [];
      List<PaymentMethodModel> payments =
          List.from(PaymentMethodModel.listPayment);

      final transportQuery =
          await FirebaseFirestore.instance.collection('Transport').get();
      for (int i = 0; i < transportQuery.size; i++) {
        transports
            .add(TransportModel.fromSnapshot(transportQuery.docs[i], i == 0));
      }

      emit(
        state.copyWith(
          isLoading: false,
          showLoadingDialog: false,
          userAddress: event.newAddress,
          transports: transports,
          selectedTransport: transports.firstOrNull,
          payments: payments,
          selectedPayments: payments.firstOrNull,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          showLoadingDialog: false,
          userAddress: event.newAddress,
        ),
      );
    }
  }

  _onUpdateEmptyAddress(CheckoutUpdateEmptyAddressEvent event, Emitter emit) {
    List<PaymentMethodModel> payments =
        List.from(PaymentMethodModel.listPayment);

    emit(state.copyWith(
      showLoadingDialog: false,
      isLoading: false,
      payments: payments,
      selectedPayments: payments.firstOrNull,
      transports: event.transports,
      selectedTransport: event.transports.firstOrNull,
    ));
  }

  _onOder(CheckoutSimpleOrderEvent event, Emitter emit) async {
    if (state.userAddress != null) {
      emit(state.copyWith(showLoadingDialog: true));

      String uid = FirebaseAuth.instance.currentUser!.uid;

      try {
        final transactionCollection = FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction');

        await transactionCollection
            .add(event.transaction.toJson())
            .then((value) async {
          for (var ele in event.transaction.products) {
            await FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Transaction')
                .doc(value.id)
                .collection('Products')
                .add(ele.toJson());
          }

          await FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .collection('Notification')
              .add(createNotification(value.id).toJson());

          if (event.fromCart) {
            final cartCollection = FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Cart');
            for (var ele in event.transaction.products) {
              await cartCollection.doc(ele.id).delete();
            }
          }

          emit(CheckoutOrderSuccessfulState(idTransaction: value.id));
        });
      } on FirebaseException catch (e) {
        emit(state.copyWith(showLoadingDialog: false));
        Fluttertoast.showToast(msg: "Error: ${e.message}");
      }
    } else if (state.userAddress == null) {
      Fluttertoast.showToast(msg: 'Vui lòng cung cấp địa chỉ giao hàng');
    }
  }

  _onZaloPayOrder(CheckoutZaloPayOrderEvent event, Emitter emit) async {
    if (state.userAddress != null) {
      emit(state.copyWith(showLoadingDialog: true));

      var createOrderResult =
          await createOrder(event.transaction.totalPrice.toInt());
      if (createOrderResult != null) {
        final String result = await platform.invokeMethod(
            'payOrder', {"zptoken": createOrderResult.zptranstoken});
        if (result == 'Payment Success') {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          try {
            final transactionCollection = FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Transaction');

            await transactionCollection
                .add(event.transaction.toJson())
                .then((value) async {
              for (var ele in event.transaction.products) {
                await FirebaseFirestore.instance
                    .collection('User')
                    .doc(uid)
                    .collection('Transaction')
                    .doc(value.id)
                    .collection('Products')
                    .add(ele.toJson());
              }
              await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .collection('Notification')
                  .add(createNotification(value.id).toJson());

              if (event.fromCart) {
                final cartCollection = FirebaseFirestore.instance
                    .collection('User')
                    .doc(uid)
                    .collection('Cart');
                for (var ele in event.transaction.products) {
                  await cartCollection.doc(ele.id).delete();
                }
              }

              emit(CheckoutOrderSuccessfulState(idTransaction: value.id));
            });
          } on FirebaseException catch (e) {
            emit(state.copyWith(showLoadingDialog: false));
            Fluttertoast.showToast(msg: "Error: ${e.message}");
          }
        } else {
          switch (result) {
            case 'User Canceled':
              emit(state.copyWith(showLoadingDialog: false));
              Fluttertoast.showToast(msg: "Thanh toán bị hủy");
              break;
            case 'Payment failed':
              emit(state.copyWith(showLoadingDialog: false));
              Fluttertoast.showToast(msg: "Lỗi thanh toán");
              break;
          }
        }
      } else {
        emit(state.copyWith(showLoadingDialog: false));
        Fluttertoast.showToast(msg: "Lỗi không xác định");
      }
    } else if (state.userAddress == null) {
      Fluttertoast.showToast(msg: 'Vui lòng cung cấp địa chỉ giao hàng');
    }
  }

  NotificationModel createNotification(String checkOutID) {
    return NotificationModel(
      id: '',
      title: 'Đặt hàng thành công',
      content:
          'Yêu cầu của đơn hàng $checkOutID đã được gửi đến cho người bán. Bạn có thể theo dõi trạng thái đơn hàng ở trong mục Đơn hàng của tôi.',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_0',
    );
  }

  Future<CreateOrderResponse?> createOrder(int price) async {
    var header = <String, String>{};
    header["Content-Type"] = "application/x-www-form-urlencoded";

    var body = <String, String>{};
    body["app_id"] = ZaloAppConfig.appId;
    body["app_user"] = ZaloAppConfig.appName;
    body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
    body["amount"] = price.toStringAsFixed(0);
    body["app_trans_id"] =
        DateFormat('yyMMdd_hhmmss').format(DateTime.now()).toString();
    body["embed_data"] = "{}";
    body["item"] = "[]";
    body["bank_code"] = "zalopayapp";
    body["description"] = getDescription(body["app_trans_id"]);

    var dataGetMac =
        '${body["app_id"]}|${body["app_trans_id"]}|${body["app_user"]}|${body["amount"]}|${body["app_time"]}|${body["embed_data"]}|${body["item"]}';
    body["mac"] = getMacCreateOrder(dataGetMac);

    http.Response response = await http.post(
      Uri.parse(Uri.encodeFull(ZaloAppConfig.createOrderUrl)),
      headers: header,
      body: body,
    );

    if (response.statusCode != 200) {
      return null;
    }

    var data = jsonDecode(response.body);

    return CreateOrderResponse.fromJson(data);
  }

  String getDescription(String? body) => "IBOO thanh toán cho đơn hàng  #$body";

  String getMacCreateOrder(String dataGetMac) {
    var hmac = Hmac(sha256, utf8.encode(ZaloAppConfig.key1));
    return hmac.convert(utf8.encode(dataGetMac)).toString();
  }

  _onUpdatePaymentMethod(CheckoutUpdatePaymentMethodEvent event, Emitter emit) {
    emit(state.copyWith(
      showLoadingDialog: false,
      selectedPayments: event.payment,
    ));
  }

  _onUpdateTransport(CheckoutUpdateTransportEvent event, Emitter emit) {
    emit(
      state.copyWith(
        selectedTransport: event.newTransport,
        showLoadingDialog: false,
      ),
    );
  }
}
